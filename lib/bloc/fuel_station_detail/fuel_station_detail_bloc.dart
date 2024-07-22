import 'package:bloc/bloc.dart';
import 'package:carfuel_frontend/data/repository/fuel_station_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'fuel_station_detail_event.dart';
part 'fuel_station_detail_state.dart';

class FuelStationDetailBloc
    extends Bloc<FuelStationDetailEvent, FuelStationDetailState> {
  final FuelStationRepository fuelStationRepository;

  FuelStationDetailBloc({required this.fuelStationRepository})
      : super(FuelStationDetailInitial()) {
    on<FuelStationRemovalRequested>((event, emit) async {
      emit(FuelStationDetailLoading());

      try {
        await fuelStationRepository.removeFuelStation(event.stationId);

        emit(FuelStationDetailSuccess());
      } catch (e) {
        emit(FuelStationDetailFailure(errorMessage: e.toString()));
      }
    });
    on<FuelStationCreateRequested>((event, emit) async {
      emit(FuelStationDetailLoading());

      try {
        await fuelStationRepository.createFuelStation(event.stationData);

        emit(FuelStationDetailSuccess());
      } catch (e) {
        emit(FuelStationDetailFailure(errorMessage: e.toString()));
      }
    });
    on<FuelStationUpdateRequested>((event, emit) async {
      emit(FuelStationDetailLoading());

      try {
        await fuelStationRepository.updateFuelStation(
            event.stationId, event.stationData);

        emit(FuelStationDetailSuccess());
      } catch (e) {
        emit(FuelStationDetailFailure(errorMessage: e.toString()));
      }
    });
  }
}
