import 'dart:async';
import 'dart:convert';
import 'dart:io'; // For SocketException
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart'; // For connectivity check
import '../../../../core/constants.dart';
import '../models/country_model.dart';

class CountryApi {
  final http.Client client;
  final Connectivity connectivity;

  CountryApi({required this.client, required this.connectivity});

  Future<List<Country>> fetchCountries() async {
    var connectivityResult = await connectivity.checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      throw SocketException('No Internet connection. Please check your network settings.');
    }

    try {
      final response = await client
          .get(
            Uri.parse(APIConstants.listCountries.replaceFirst('http:', 'https:')),
          )
          .timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Country.fromJson(json)).toList();
      } else {
        throw HttpException('Failed to load countries (Status Code: ${response.statusCode})');
      }
    } on SocketException {
      throw SocketException('No Internet connection. Please check your network settings.');
    } on TimeoutException {
      throw TimeoutException('The connection has timed out. Please try again later.');
    } on FormatException {
      throw FormatException('Bad response format. Please contact support.');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<List<Country>> fetchCountryDetails(String name) async {
    var connectivityResult = await connectivity.checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      throw SocketException('No Internet connection. Please check your network settings.');
    }

    try {
      final response = await client
          .get(
            Uri.parse(APIConstants.countryDetails(name).replaceFirst('http:', 'https:')),
          )
          .timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Country.fromJson(json)).toList();
      } else {
        throw HttpException('Failed to load country details (Status Code: ${response.statusCode})');
      }
    } on SocketException {
      throw SocketException('No Internet connection. Please check your network settings.');
    } on TimeoutException {
      throw TimeoutException('The connection has timed out. Please try again later.');
    } on FormatException {
      throw FormatException('Bad response format. Please contact support.');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
