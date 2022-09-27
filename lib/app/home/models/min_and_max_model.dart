import 'package:json_annotation/json_annotation.dart';

part 'min_and_max_model.g.dart';

@JsonSerializable()
class MinAndMaxModel {
  double? max;
  String? maxHour;
  double? min;
  String? minHour;

  MinAndMaxModel({this.max, this.maxHour, this.min, this.minHour});

   factory MinAndMaxModel.fromJson(Map<String, dynamic> json) =>
      _$MinAndMaxModelFromJson(json);

  Map<String, dynamic> toJson() => _$MinAndMaxModelToJson(this);
}