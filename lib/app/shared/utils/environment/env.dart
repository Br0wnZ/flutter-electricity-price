import 'package:electricity_price/app/shared/utils/environment/environment.dart';

import '../../../../env/environment_dev.dart';
import '../../../../env/environment_prod.dart';

class ENV {

  ENV._privateConstructor();
  static final ENV _instance = ENV._privateConstructor();


  factory ENV() {
    return _instance;
  }

  late Environment config;

  initConfig(String environment) {
    config = _getConfig(environment);
  }

  Environment _getConfig(String environment) {
    switch (environment) {
      case EnvDev.name:
        return EnvProd();
      default:
        return EnvDev();
    }
  }
}