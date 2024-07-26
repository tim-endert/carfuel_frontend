import 'package:bloc_test/bloc_test.dart';
import 'package:carfuel_frontend/bloc/fuel_station_overview_bloc/fuel_station_overview_bloc.dart';
import 'package:carfuel_frontend/data/repository/fuel_station_repository.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../fixtures/fuel_station_fixtures.dart';

class MockFuelStationRepository extends Mock implements FuelStationRepository {}

class MockDioException extends Mock implements DioException {}

void main() {
  late FuelStationRepository fuelStationRepository;
  late FuelStationOverviewBloc fuelStationOverviewBloc;

  setUp(() {
    fuelStationRepository = MockFuelStationRepository();
    fuelStationOverviewBloc =
        FuelStationOverviewBloc(fuelStationRepository: fuelStationRepository);
  });

  group(FuelStationOverviewBloc, () {
    test("the initial state status of the bloc", () {
      expect(fuelStationOverviewBloc.state.status, FuelStationStatus.initial);
    });

    blocTest<FuelStationOverviewBloc, FuelStationOverviewState>(
      'emits [loading, loaded] when FetchFuelStations is added and fetch is successful',
      build: () {
        when(() => fuelStationRepository.fetchFuelStations()).thenAnswer(
          (_) async => fuelStationFixtures,
        );
        return FuelStationOverviewBloc(
            fuelStationRepository: fuelStationRepository);
      },
      act: (bloc) => bloc.add(FetchFuelStations()),
      expect: () => <FuelStationOverviewState>[
        const FuelStationOverviewState(status: FuelStationStatus.loading),
        const FuelStationOverviewState(
            status: FuelStationStatus.loaded,
            fuelStations: fuelStationFixtures),
      ],
    );
  });

  blocTest<FuelStationOverviewBloc, FuelStationOverviewState>(
    'emits [loading, failure] when FetchFuelStations is added and fetch fails',
    build: () {
      final exception = MockDioException();
      when(() => fuelStationRepository.fetchFuelStations())
          .thenThrow(exception);
      return FuelStationOverviewBloc(
          fuelStationRepository: fuelStationRepository);
    },
    act: (bloc) => bloc.add(FetchFuelStations()),
    expect: () => <FuelStationOverviewState>[
      const FuelStationOverviewState(status: FuelStationStatus.loading),
      const FuelStationOverviewState(
          status: FuelStationStatus.failure, errorMessage: 'Error'),
    ],
  );
}
