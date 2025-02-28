import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart'; // For connectivity check

import '../../data/models/country_model.dart';
import '../../data/repositories/country_repository.dart';
import '../../data/sources/country_api.dart';
import '../blocs/bloc/country_details_bloc.dart';

class CountryDetailsScreen extends StatelessWidget {
  final String countryName;
  const CountryDetailsScreen({super.key, required this.countryName});

  @override
  Widget build(BuildContext context) {
    final countryRepository = CountryRepository(
      api: CountryApi(client: http.Client(), connectivity: Connectivity()),
    );

    return BlocProvider(
      create: (context) => CountryDetailsBloc(
        repository: countryRepository,
        connectivity: Connectivity(),
      )..add(FetchCountryDetails(countryName: countryName)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            countryName,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600, color: Colors.black, fontSize: 25),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<CountryDetailsBloc, CountryDetailsState>(
          builder: (context, state) {
            if (state is CountryDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CountryDetailsLoaded) {
              final Country country = state.country;
              return Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Flag display with circular border
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(
                                  country.flagUrl,
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.flag, size: 150),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Country Name
                            Center(
                              child: Text(
                                country.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Details using ListTile style rows
                            _buildDetailRow(context,
                                icon: Icons.location_city,
                                label: 'Capital',
                                value: country.capital.isNotEmpty
                                    ? country.capital.join(', ')
                                    : 'N/A'),
                            _buildDetailRow(context,
                                icon: Icons.language,
                                label: 'Languages',
                                value: country.languages.join(', ')),
                            _buildDetailRow(context,
                                icon: Icons.map,
                                label: 'Region',
                                value: country.region),
                            _buildDetailRow(context,
                                icon: Icons.map_outlined,
                                label: 'Subregion',
                                value: country.subregion),
                            _buildDetailRow(context,
                                icon: Icons.people,
                                label: 'Population',
                                value: country.population.toString()),
                            _buildDetailRow(context,
                                icon: Icons.monetization_on,
                                label: 'Currency',
                                value: country.currencies.join(', ')),
                            _buildDetailRow(context,
                                icon: Icons.landscape,
                                label: 'Area',
                                value: '${country.area} km²'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else if (state is CountryDetailsError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          context.read<CountryDetailsBloc>().add(
                              FetchCountryDetails(countryName: countryName));
                        },
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Center(
              child: Text(
                "Country Detail Unavailable",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: Colors.red),
              ),
            );
          },
        ),
      ),
    );
  }

  // A method to create detail row with an icon, label, and value.
  Widget _buildDetailRow(BuildContext context,
      {required IconData icon, required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Theme.of(context).primaryColor),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: '$label: ',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w500, color: Colors.black),
                children: [
                  TextSpan(
                    text: value,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
