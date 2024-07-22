part of 'fuel_station_overview_bloc.dart';

enum FuelStationStatus { initial, loading, loaded, failure }

class FuelStationOverviewState {
  const FuelStationOverviewState({
    this.status = FuelStationStatus.initial,
    this.fuelStations = const [],
  });

  FuelStationOverviewState copyWith({
    FuelStationStatus Function()? status,
    List<FuelStation> Function()? fuelStations,
  }) {
    return FuelStationOverviewState(
      status: status != null ? status() : this.status,
      fuelStations: fuelStations != null ? fuelStations() : this.fuelStations,
    );
  }

  final List<FuelStation> fuelStations;
  final FuelStationStatus status;

  List<Object?> get props => [status, fuelStations];
}
