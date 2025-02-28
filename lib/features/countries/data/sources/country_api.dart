import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/constraints.dart';
import '../models/country_model.dart';

class CountryApi {
  final http.Client client;

  CountryApi({required this.client});

  Future<List<Country>> fetchCountries() async {
    final response = await client.get(Uri.parse(APIConstants.listCountries));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => Country.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load countries');
    }
  }

  Future<List<Country>> fetchCountryDetails(String name) async {
    final response =
        await client.get(Uri.parse(APIConstants.countryDetails(name)));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => Country.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load country details');
    }
  }
}
