import 'package:electricity_price/app/home/models/average_price_model.dart';
import 'package:electricity_price/app/home/models/price_model.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part "price_repository.g.dart";

@RestApi()
abstract class PriceRepository {

  factory PriceRepository(Dio dio, {String baseUrl}) = _PriceRepository;

  @GET('all?zone=PCB')
  Future<Map<String, PriceModel>> getPrices();

  @GET('avg?zone=PCB')
  Future<AveragePriceModel> getAveragePrices();
}