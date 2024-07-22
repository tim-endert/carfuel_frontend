// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fuel_station_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FuelStationList _$FuelStationListFromJson(Map<String, dynamic> json) =>
    FuelStationList(
      fuelStationList: (json['fuelStationList'] as List<dynamic>)
          .map((e) => FuelStation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FuelStationListToJson(FuelStationList instance) =>
    <String, dynamic>{
      'fuelStationList': instance.fuelStationList,
    };
