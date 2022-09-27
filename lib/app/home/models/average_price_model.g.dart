// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'average_price_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AveragePriceModel _$AveragePriceModelFromJson(Map<String, dynamic> json) =>
    AveragePriceModel(
      date: json['date'] as String?,
      market: json['market'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      units: json['units'] as String?,
    );

Map<String, dynamic> _$AveragePriceModelToJson(AveragePriceModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'market': instance.market,
      'price': instance.price,
      'units': instance.units,
    };
