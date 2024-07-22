import 'package:bloc/bloc.dart';
import 'package:carfuel_frontend/data/models/fuel_station.dart';
import 'package:carfuel_frontend/data/repository/fuel_station_repository.dart';
import 'package:meta/meta.dart';

part 'fuel_station_overview_event.dart';
part 'fuel_station_overview_state.dart';

class FuelStationOverviewBloc
    extends Bloc<FuelStationOverviewEvent, FuelStationOverviewState> {
  final FuelStationRepository fuelStationRepository;

  FuelStationOverviewBloc({required this.fuelStationRepository})
      : super(const FuelStationOverviewState()) {
    on<FetchFuelStations>(_onFetchFuelStations);
  }

  Future<void> _onFetchFuelStations(
      FetchFuelStations event, Emitter<FuelStationOverviewState> emit) async {
    emit(state.copyWith(status: () => FuelStationStatus.loading));

    try {
      final fuelStations = await fuelStationRepository.fetchFuelStations();

      emit(
        state.copyWith(
          status: () => FuelStationStatus.loaded,
          fuelStations: () => fuelStations,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: () => FuelStationStatus.failure));
    }
  }
}
