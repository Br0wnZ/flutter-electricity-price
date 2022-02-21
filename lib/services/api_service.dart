import 'dart:convert' as convert;
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:electricity_price/models/price.dart';

abstract class ApiService {
  Future<dynamic> getData();
  Future<dynamic> getAveragePrice();
}

class HttpService implements ApiService {
  var url = 'https://api.preciodelaluz.org/v1/prices/all?zone=PCB';
  Future<dynamic> getData() async {
    var response = await http.get(Uri.parse(url));
    var jsonResponse = convert.jsonDecode(response.body) as dynamic;
    List<Price> array = [];
    for (var item in jsonResponse.values) {
      array.add(Price.fromJson(item));
    }
    var res = await getAllData();
    return res;
  }

  Future<dynamic> getAveragePrice() async {
    var url = 'https://api.preciodelaluz.org/v1/prices/avg?zone=PCB';

    var response = await http.get(Uri.parse(url));
    var jsonResponse = convert.jsonDecode(response.body) as dynamic;
    return jsonResponse;
  }

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
      responses.add(getMaxAndMin(prices));
    } else {
      responses.add(convert.jsonDecode(response.body));
    }
    return responses;
  }

  dynamic getMaxAndMin(List<double> prices) {
    return {
      'max': prices.reduce((curr, next) => curr > next? curr: next),
      'min': prices.reduce((curr, next) => curr < next? curr: next)
    };
  }
}
