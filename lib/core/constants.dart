class APIConstants {
  static const String baseUrl = 'https://restcountries.com/v3.1';
  static const String listCountries =
      '$baseUrl/region/africa?status=true&fields=name,languages,capital,flags';
  static String countryDetails(String name) =>
      '$baseUrl/name/$name';
}
