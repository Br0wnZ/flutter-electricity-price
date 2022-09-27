import 'package:json_annotation/json_annotation.dart';

part 'average_price_model.g.dart';

@JsonSerializable()
class AveragePriceModel {
  String? date;
  String? market;
  double? price;
  String? units;

  AveragePriceModel({this.date, this.market, this.price, this.units});

  factory AveragePriceModel.fromJson(Map<String, dynamic> json) =>
      _$AveragePriceModelFromJson(json);

  Map<String, dynamic> toJson() => _$AveragePriceModelToJson(this);
}