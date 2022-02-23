import 'package:flutter/foundation.dart';
import 'package:electricity_price/service_locator.dart';
import 'package:electricity_price/services/api_service.dart';


class HomeViewModel extends ChangeNotifier {

    HttpService _http = getIt<HttpService>();
    late List<dynamic> _responses;

    Future loadData() async {
      _responses = await _http.getAllData();
      return _responses;
    }
}