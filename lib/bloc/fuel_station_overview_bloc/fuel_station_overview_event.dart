part of 'fuel_station_overview_bloc.dart';

@immutable
sealed class FuelStationOverviewEvent {}

final class FetchFuelStations extends FuelStationOverviewEvent {}
