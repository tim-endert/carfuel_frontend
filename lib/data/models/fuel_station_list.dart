import 'package:carfuel_frontend/data/models/fuel_station.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fuel_station_list.g.dart';

@JsonSerializable()
class FuelStationList {
  final List<FuelStation> fuelStationList;

  FuelStationList({required this.fuelStationList});

  factory FuelStationList.fromJson(Map<String, dynamic> json) =>
      _$FuelStationListFromJson(json);
  Map<String, dynamic> toJson() => _$FuelStationListToJson(this);
}
