import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/country_model.dart';

class CountryCard extends StatelessWidget {
  final Country country;
  const CountryCard({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: Image.network(
          country.flagUrl,
          width: 50,
          height: 50,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.flag),
        ),
        title: Text(
          country.name,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.w500, color: Colors.black),
        ),
        subtitle: Text(country.capital.isNotEmpty
            ? country.capital.join(', ')
            : 'No Capital'),
        onTap: () {
          // Navigate using go_router, passing the country name as a parameter
          context.go('/details/${country.name}');
        },
      ),
    );
  }
}
