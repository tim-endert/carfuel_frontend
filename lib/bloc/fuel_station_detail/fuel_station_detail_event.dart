part of 'fuel_station_detail_bloc.dart';

@immutable
sealed class FuelStationDetailEvent {}

final class FuelStationRemovalRequested extends FuelStationDetailEvent {
  FuelStationRemovalRequested(this.stationId);

  final int stationId;

  List<Object> get props => [stationId];
}

final class FuelStationCreateRequested extends FuelStationDetailEvent {
  FuelStationCreateRequested(this.stationData);

  final Map<String, dynamic> stationData;

  List<Object> get props => [stationData];
}

final class FuelStationUpdateRequested extends FuelStationDetailEvent {
  FuelStationUpdateRequested(this.stationData, this.stationId);

  final Map<String, dynamic> stationData;
  final int stationId;

  List<Object> get props => [stationData, stationId];
}
