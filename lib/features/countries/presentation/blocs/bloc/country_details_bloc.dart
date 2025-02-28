import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io'; // For SocketException
import 'dart:async'; // For TimeoutException
import 'package:connectivity_plus/connectivity_plus.dart'; // For connectivity check
import '../../../data/models/country_model.dart';
import '../../../data/repositories/country_repository.dart';

part 'country_details_event.dart';
part 'country_details_state.dart';

class CountryDetailsBloc extends Bloc<CountryDetailsEvent, CountryDetailsState> {
  final CountryRepository repository;
  final Connectivity connectivity;

  CountryDetailsBloc({required this.repository, required this.connectivity}) : super(CountryDetailsInitial()) {
    on<FetchCountryDetails>((event, emit) async {
      emit(CountryDetailsLoading());

      // Check network connectivity
      var connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.none)) {
        emit(CountryDetailsError(message: 'No Internet connection. Please check your network settings.'));
        return;
      }

      try {
        final countries = await repository.getCountryDetails(event.countryName);
        emit(CountryDetailsLoaded(country: countries.first));
      } on SocketException {
        emit(CountryDetailsError(message: 'No Internet connection. Please check your network settings.'));
      } on TimeoutException {
        emit(CountryDetailsError(message: 'The connection has timed out. Please try again later.'));
      } on HttpException catch (e) {
        emit(CountryDetailsError(message: e.message));
      } on FormatException {
        emit(CountryDetailsError(message: 'Bad response format. Please contact support.'));
      } catch (e) {
        emit(CountryDetailsError(message: 'An unexpected error occurred: $e'));
      }
    });
  }
}
