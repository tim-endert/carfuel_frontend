import 'package:carfuel_frontend/bloc/fuel_station_detail/fuel_station_detail_bloc.dart';
import 'package:carfuel_frontend/bloc/fuel_station_overview_bloc/fuel_station_overview_bloc.dart';
import 'package:carfuel_frontend/data/repository/fuel_station_repository.dart';
import 'package:carfuel_frontend/presentation/screens/fuel_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<FuelStationRepository>(
      create: (context) => FuelStationRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<FuelStationOverviewBloc>(
            create: (BuildContext context) => FuelStationOverviewBloc(
              fuelStationRepository: context.read<FuelStationRepository>(),
            )..add(
                FetchFuelStations(),
              ),
          ),
          BlocProvider<FuelStationDetailBloc>(
            create: (BuildContext context) => FuelStationDetailBloc(
              fuelStationRepository: context.read<FuelStationRepository>(),
            ),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      brightness: MediaQuery.platformBrightnessOf(context),
      seedColor: Colors.indigo,
    );

    return MaterialApp(
      title: 'CarFuel',
      theme: ThemeData(
        snackBarTheme: SnackBarThemeData(backgroundColor: colorScheme.primary),
        colorScheme: colorScheme,
        useMaterial3: true,
      ),
      routes: {
        "/": (context) => const FuelMapScreen(),
      },
    );
  }
}
