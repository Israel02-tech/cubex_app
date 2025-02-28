import '../sources/country_api.dart';
import '../models/country_model.dart';

class CountryRepository {
  final CountryApi api;

  CountryRepository({required this.api});

  Future<List<Country>> getCountries() async {
    return await api.fetchCountries();
  }

  Future<List<dynamic>> getCountryDetails(String name) async {
    return await api.fetchCountryDetails(name);
  }
}
