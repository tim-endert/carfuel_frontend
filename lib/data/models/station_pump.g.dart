// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_pump.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationPump _$StationPumpFromJson(Map<String, dynamic> json) => StationPump(
      id: (json['id'] as num).toInt(),
      fuelType: json['fuelType'] as String,
      price: (json['price'] as num).toDouble(),
      available: json['available'] as bool,
    );

Map<String, dynamic> _$StationPumpToJson(StationPump instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fuelType': instance.fuelType,
      'price': instance.price,
      'available': instance.available,
    };
