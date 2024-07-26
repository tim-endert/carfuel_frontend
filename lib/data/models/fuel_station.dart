import 'package:carfuel_frontend/data/models/station_pump.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fuel_station.g.dart';

@JsonSerializable()
class FuelStation extends Equatable {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "address")
  final String address;
  @JsonKey(name: "city")
  final String city;
  @JsonKey(name: "latitude")
  final double latitude;
  @JsonKey(name: "longitude")
  final double longitude;
  @JsonKey(name: "pumps")
  final List<StationPump>? pumps;

  const FuelStation({
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

  @override
  List<Object?> get props => [id, name, address, city, latitude, longitude];

  Map<String, dynamic> toJson() => _$FuelStationToJson(this);
}
