import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/country_model.dart';
import '../../../data/repositories/country_repository.dart';

part 'country_details_event.dart';
part 'country_details_state.dart';

class CountryDetailsBloc
    extends Bloc<CountryDetailsEvent, CountryDetailsState> {
  final CountryRepository repository;

  CountryDetailsBloc({required this.repository})
      : super(CountryDetailsInitial()) {
    on<FetchCountryDetails>((event, emit) async {
      emit(CountryDetailsLoading());
      try {
        final countries = await repository.getCountryDetails(event.countryName);
        emit(CountryDetailsLoaded(country: countries.first));
      } catch (e) {
        emit(CountryDetailsError(message: e.toString()));
      }
    });
  }
}
