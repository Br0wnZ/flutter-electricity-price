import 'package:electricity_price/app/shared/utils/environment/environment.dart';

class EnvProd implements Environment {
  static const String name = 'PROD';
  String get basePath => 'https://api.preciodelaluz.org/v1/prices/';
  bool get production => true;
}