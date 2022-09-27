import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:electricity_price/app/home/cubit/home_state.dart';
import 'package:electricity_price/app/home/models/average_price_model.dart';
import 'package:electricity_price/app/home/models/min_and_max_model.dart';
import 'package:electricity_price/app/home/models/price_model.dart';
import 'package:electricity_price/app/home/repositories/price_repository.dart';

class HomeCubit extends Cubit<HomeStateCubit> {
  final PriceRepository _priceRepository;
  HomeCubit(this._priceRepository) : super(HomeStateCubit());

  loadPrices() async {
    emit(state.copyWith(
      loading: true,
    ));
    try {
      final responses = await Future.wait(
          [_priceRepository.getPrices(), _priceRepository.getAveragePrices()]);
      final prices = responses[0] as Map<String, PriceModel>;
      final averagePrice = responses[1] as AveragePriceModel;
      final minMax = _getMinAndMaxPrice(prices);
      final chartPrices = _getChartPrices(prices);
      List<PriceModel> priceList = [];
      for (var item in prices.values) {
        priceList.add(item);
      }
      emit(state.copyWith(
          loading: false,
          priceList: priceList,
          minAndMax: minMax,
          averagePriceModel: averagePrice,
          chartPrices: chartPrices));
    } on DioError catch (e) {
      emit(state.copyWith(
        loading: false,
        error: e,
      ));
    }
  }

  List<double> _getChartPrices(Map<String, PriceModel> prices) {
    List<double> chartPrices = [];
    for (var item in prices.values) {
      chartPrices.add(item.price!);
    }
    return chartPrices
        .map((e) => double.parse((e / 1000).toStringAsFixed(5)))
        .toList();
  }

  List<double> _getPriceListFromResponse(Map<String, PriceModel> response) {
    List<double> hourlyPrices = [];
    for (var price in response.values) {
      hourlyPrices.add(price.price!);
    }
    return hourlyPrices;
  }

  List<PriceModel> _getHourlyPricesFromResponse(
      Map<String, PriceModel> response) {
    List<PriceModel> prices = [];
    for (var price in response.values) {
      prices.add(price);
    }
    return prices;
  }

  MinAndMaxModel _getMaxAndMin(List<double> prices, List<PriceModel> list) {
    var max = prices.reduce((curr, next) => curr > next ? curr : next);
    var maxHour = list.where((element) => element.price == max).toList();
    var min = prices.reduce((curr, next) => curr < next ? curr : next);
    var minHour = list.where((element) => element.price == min).toList();
    return MinAndMaxModel(
        max: max, maxHour: maxHour[0].hour, min: min, minHour: minHour[0].hour);
  }

  _getMinAndMaxPrice(Map<String, PriceModel> prices) {
    final minAndMax = _getMaxAndMin(_getPriceListFromResponse(prices),
        _getHourlyPricesFromResponse(prices));
    return minAndMax;
  }
}
