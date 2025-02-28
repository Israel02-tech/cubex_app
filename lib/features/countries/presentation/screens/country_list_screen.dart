import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart'; // For connectivity check
import '../../data/repositories/country_repository.dart';
import '../../data/sources/country_api.dart';
import '../blocs/bloc/country_list_bloc.dart';
import '../widgets/country_card.dart';

class CountryListScreen extends StatelessWidget {
  const CountryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final countryRepository = CountryRepository(
      api: CountryApi(client: http.Client(), connectivity: Connectivity()),
    );

    return BlocProvider(
      create: (context) => CountryListBloc(
        repository: countryRepository,
        connectivity: Connectivity(),
      )..add(FetchCountries()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('African Countries'),
        ),
        body: BlocBuilder<CountryListBloc, CountryListState>(
          builder: (context, state) {
            if (state is CountryListLoading) {
              return Center(
                child: CircularProgressIndicator(color: Colors.blue),
              );
            } else if (state is CountryListLoaded) {
              return ListView.builder(
                itemCount: state.countries.length,
                itemBuilder: (context, index) {
                  return CountryCard(country: state.countries[index]);
                },
              );
            } else if (state is CountryListError) {
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
                          context.read<CountryListBloc>().add(FetchCountries());
                        },
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
