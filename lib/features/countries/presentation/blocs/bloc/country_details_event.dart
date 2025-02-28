part of 'country_details_bloc.dart';

abstract class CountryDetailsEvent extends Equatable {
  const CountryDetailsEvent();
  @override
  List<Object> get props => [];
}

class FetchCountryDetails extends CountryDetailsEvent {
  final String countryName;
  const FetchCountryDetails({required this.countryName});

  @override
  List<Object> get props => [countryName];
}
