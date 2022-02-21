import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:electricity_price/models/price.dart';

abstract class ApiService {
  Future<dynamic> getData();
}

class HttpService implements ApiService {
  var url = 'https://api.preciodelaluz.org/v1/prices/all?zone=PCB';
  Future<List<Price>> getData() async {
    var response = await http.get(Uri.parse(url));
    var jsonResponse = convert.jsonDecode(response.body) as dynamic;
    List<Price> array = [];
    for (var item in jsonResponse.values) {
      array.add(Price.fromJson(item));
    }
    return array;
  }
}
