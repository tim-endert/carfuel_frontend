import 'package:carfuel_frontend/data/models/station_pump.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fuel_station.g.dart';

@JsonSerializable()
class FuelStation {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "address")
  String address;
  @JsonKey(name: "city")
  String city;
  @JsonKey(name: "latitude")
  double latitude;
  @JsonKey(name: "longitude")
  double longitude;
  @JsonKey(name: "pumps")
  List<StationPump>? pumps;

  FuelStation({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.latitude,
    required this.longitude,
    this.pumps,
  });

  factory FuelStation.fromJson(Map<String, dynamic> json) =>
      _$FuelStationFromJson(json);

  Map<String, dynamic> toJson() => _$FuelStationToJson(this);
}
