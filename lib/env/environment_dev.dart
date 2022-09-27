import 'package:electricity_price/app/shared/utils/environment/environment.dart';

class EnvDev implements Environment {
  static const String name = 'DEV';
  String get basePath => 'https://api.preciodelaluz.org/v1/prices/';
  bool get production => false;
}