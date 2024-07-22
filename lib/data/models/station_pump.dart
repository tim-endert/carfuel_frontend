import 'package:json_annotation/json_annotation.dart';

part 'station_pump.g.dart';

@JsonSerializable()
class StationPump {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "fuelType")
  String fuelType;
  @JsonKey(name: "price")
  double price;
  @JsonKey(name: "available")
  bool available;

  StationPump({
    required this.id,
    required this.fuelType,
    required this.price,
    required this.available,
  });

  factory StationPump.fromJson(Map<String, dynamic> json) =>
      _$StationPumpFromJson(json);

  Map<String, dynamic> toJson() => _$StationPumpToJson(this);
}
