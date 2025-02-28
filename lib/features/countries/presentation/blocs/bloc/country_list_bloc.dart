import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/country_model.dart';
import '../../../data/repositories/country_repository.dart';

part 'country_list_event.dart';
part 'country_list_state.dart';

class CountryListBloc extends Bloc<CountryListEvent, CountryListState> {
  final CountryRepository repository;

  CountryListBloc({required this.repository}) : super(CountryListInitial()) {
    on<FetchCountries>((event, emit) async {
      emit(CountryListLoading());
      try {
        final countries = await repository.getCountries();
        emit(CountryListLoaded(countries: countries));
      } catch (e) {
        emit(CountryListError(message: e.toString()));
      }
    });
  }
}
