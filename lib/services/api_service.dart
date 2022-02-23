import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:electricity_price/models/price.dart';

abstract class ApiService {
  Future<dynamic> getAllData();
}

class HttpService implements ApiService {

  Future<dynamic> getAllData() async {
    var responses = await Future.wait([
      http.get(
          Uri.parse('https://api.preciodelaluz.org/v1/prices/all?zone=PCB')),
      http.get(
          Uri.parse('https://api.preciodelaluz.org/v1/prices/avg?zone=PCB')),
    ]);
    return <dynamic>[
      ..._parseResponse(responses[0], 0),
      ..._parseResponse(responses[1], 1),
    ];
  }

  List<dynamic> _parseResponse(http.Response response, int index) {
    List<dynamic> responses = [];
    if (response.statusCode == 200 && index == 0) {
      var jsonResponse = convert.jsonDecode(response.body) as dynamic;
      List<Price> array = [];
      List<double> prices = [];
      for (var item in jsonResponse.values) {
        array.add(Price.fromJson(item));
        prices.add(Price.fromJson(item).price!);
      }
      responses.add(array);
      responses.add(_getMaxAndMin(prices, array));
      responses.add(prices.map((e) => double.parse((e / 1000).toStringAsFixed(5))));
    } else {
      responses.add(convert.jsonDecode(response.body));
    }
    return responses;
  }

  Map<String, dynamic> _getMaxAndMin(List<double> prices, List<Price> list) {
    var max = prices.reduce((curr, next) => curr > next? curr: next);
    var maxHour = list.where((element) => element.price == max).toList();
    var min = prices.reduce((curr, next) => curr < next? curr: next);
    var minHour = list.where((element) => element.price == min).toList();
    return {
      'max': max,
      'maxHour': maxHour[0].hour,
      'min': min,
      'minHour': minHour[0].hour
    };

  }
}
