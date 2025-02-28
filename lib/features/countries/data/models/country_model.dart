class Country {
  final String name;
  final List<String> capital;
  final List<String> languages;
  final String flagUrl;
  final String region;
  final String subregion;
  final int population;
  final double area;
  final List<String> currencies; // List of currency names

  Country({
    required this.name,
    required this.capital,
    required this.languages,
    required this.flagUrl,
    required this.region,
    required this.subregion,
    required this.population,
    required this.area,
    required this.currencies,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    final name = json['name']['common'] ?? 'Unknown';

    List<String> capital = [];
    if (json['capital'] != null) {
      capital = List<String>.from(json['capital']);
    }

    List<String> languages = [];
    if (json['languages'] != null) {
      languages = (json['languages'] as Map<String, dynamic>)
          .values
          .map((e) => e.toString())
          .toList();
    }

    String flagUrl = '';
    if (json['flags'] != null && json['flags']['png'] != null) {
      flagUrl = json['flags']['png'];
    }

    final region = json['region'] ?? 'Unknown';
    final subregion = json['subregion'] ?? 'Unknown';

    final population = json['population'] ?? 0;

    final area = json['area'] != null ? json['area'].toDouble() : 0.0;

    List<String> currencies = [];
    if (json['currencies'] != null) {
      (json['currencies'] as Map<String, dynamic>)
          .forEach((code, currencyInfo) {
        if (currencyInfo != null && currencyInfo['name'] != null) {
          currencies.add(currencyInfo['name']);
        }
      });
    }

    return Country(
      name: name,
      capital: capital,
      languages: languages,
      flagUrl: flagUrl,
      region: region,
      subregion: subregion,
      population: population,
      area: area,
      currencies: currencies,
    );
  }
}
