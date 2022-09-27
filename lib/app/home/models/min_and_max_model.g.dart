// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'min_and_max_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MinAndMaxModel _$MinAndMaxModelFromJson(Map<String, dynamic> json) =>
    MinAndMaxModel(
      max: (json['max'] as num?)?.toDouble(),
      maxHour: json['maxHour'] as String?,
      min: (json['min'] as num?)?.toDouble(),
      minHour: json['minHour'] as String?,
    );

Map<String, dynamic> _$MinAndMaxModelToJson(MinAndMaxModel instance) =>
    <String, dynamic>{
      'max': instance.max,
      'maxHour': instance.maxHour,
      'min': instance.min,
      'minHour': instance.minHour,
    };
