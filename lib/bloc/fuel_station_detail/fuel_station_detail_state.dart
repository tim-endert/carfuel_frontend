part of 'fuel_station_detail_bloc.dart';

@immutable
sealed class FuelStationDetailState {}

final class FuelStationDetailInitial extends FuelStationDetailState {}

final class FuelStationDetailLoading extends FuelStationDetailState {}

final class FuelStationDetailSuccess extends FuelStationDetailState {}

final class FuelStationDetailFailure extends FuelStationDetailState {
  final String errorMessage;

  FuelStationDetailFailure({required this.errorMessage});

  List<Object> get props => [errorMessage];
}
