part of 'fuel_station_overview_bloc.dart';

enum FuelStationStatus { initial, loading, loaded, failure }

class FuelStationOverviewState extends Equatable {
  const FuelStationOverviewState({
    this.status = FuelStationStatus.initial,
    this.fuelStations = const [],
    this.errorMessage,
  });

  final List<FuelStation> fuelStations;
  final FuelStationStatus status;
  final String? errorMessage;

  FuelStationOverviewState copyWith({
    FuelStationStatus? status,
    List<FuelStation>? fuelStations,
    String? errorMessage,
  }) {
    return FuelStationOverviewState(
      status: status ?? this.status,
      fuelStations: fuelStations ?? this.fuelStations,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, fuelStations, errorMessage];
}
