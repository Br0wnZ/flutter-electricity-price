import 'package:get_it/get_it.dart';
import 'package:electricity_price/services/api_service.dart';

final getIt = GetIt.instance;

setupServiceLocator() {
  getIt.registerLazySingleton<HttpService>(() => HttpService());
}