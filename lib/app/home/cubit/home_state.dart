import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:electricity_price/app/home/models/average_price_model.dart';
import 'package:electricity_price/app/home/models/min_and_max_model.dart';
import 'package:electricity_price/app/home/models/price_model.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';

part 'home_state.g.dart';

@CopyWith()
class HomeStateCubit extends Equatable {
  final List<PriceModel> priceList;
  final Map<String, PriceModel> prices;
  final AveragePriceModel? averagePriceModel;
  final MinAndMaxModel? minAndMax;
  final List<double>? chartPrices;
  final bool loading;
  final DioError? error;

  const HomeStateCubit({
    this.priceList = const [],
    this.prices = const {},
    this.averagePriceModel,
    this.minAndMax,
    this.chartPrices,
    this.loading = false,
    this.error
  });

  @override
  List<Object?> get props => [prices, loading];
}
