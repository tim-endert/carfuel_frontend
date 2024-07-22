// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fuel_station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FuelStation _$FuelStationFromJson(Map<String, dynamic> json) => FuelStation(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      pumps: (json['pumps'] as List<dynamic>?)
          ?.map((e) => StationPump.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FuelStationToJson(FuelStation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'city': instance.city,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'pumps': instance.pumps,
    };
