import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io'; // For SocketException
import 'dart:async'; // For TimeoutException
import 'package:connectivity_plus/connectivity_plus.dart'; // For connectivity check
import '../../../data/models/country_model.dart';
import '../../../data/repositories/country_repository.dart';

part 'country_list_event.dart';
part 'country_list_state.dart';

class CountryListBloc extends Bloc<CountryListEvent, CountryListState> {
  final CountryRepository repository;
  final Connectivity connectivity;

  CountryListBloc({required this.repository, required this.connectivity}) : super(CountryListInitial()) {
    on<FetchCountries>((event, emit) async {
      emit(CountryListLoading());
      
      // Check network connectivity
      var connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.none)) {
        emit(CountryListError(message: 'No Internet connection. Please check your network settings.'));
        return;
      }

      try {
        final countries = await repository.getCountries();
        emit(CountryListLoaded(countries: countries));
      } on SocketException {
        emit(CountryListError(message: 'No Internet connection. Please check your network settings.'));
      } on TimeoutException {
        emit(CountryListError(message: 'The connection has timed out. Please try again later.'));
      } on HttpException catch (e) {
        emit(CountryListError(message: e.message));
      } on FormatException {
        emit(CountryListError(message: 'Bad response format. Please contact support.'));
      } catch (e) {
        emit(CountryListError(message: 'An unexpected error occurred: $e'));
      }
    });
  }
}
