import 'package:go_router/go_router.dart';
import '../features/countries/presentation/screens/country_list_screen.dart';
import '../features/countries/presentation/screens/country_details_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => CountryListScreen(),
      routes: [
        GoRoute(
          path: 'details/:countryName',
          builder: (context, state) {
            final countryName = state.pathParameters['countryName']!;
            return CountryDetailsScreen(countryName: countryName);
          },
        ),
      ],
    ),
  ],
);