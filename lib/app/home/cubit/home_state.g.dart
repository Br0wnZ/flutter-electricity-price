// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$HomeStateCubitCWProxy {
  HomeStateCubit averagePriceModel(AveragePriceModel? averagePriceModel);

  HomeStateCubit chartPrices(List<double>? chartPrices);

  HomeStateCubit error(DioError? error);

  HomeStateCubit loading(bool loading);

  HomeStateCubit minAndMax(MinAndMaxModel? minAndMax);

  HomeStateCubit priceList(List<PriceModel> priceList);

  HomeStateCubit prices(Map<String, PriceModel> prices);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HomeStateCubit(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HomeStateCubit(...).copyWith(id: 12, name: "My name")
  /// ````
  HomeStateCubit call({
    AveragePriceModel? averagePriceModel,
    List<double>? chartPrices,
    DioError? error,
    bool? loading,
    MinAndMaxModel? minAndMax,
    List<PriceModel>? priceList,
    Map<String, PriceModel>? prices,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfHomeStateCubit.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfHomeStateCubit.copyWith.fieldName(...)`
class _$HomeStateCubitCWProxyImpl implements _$HomeStateCubitCWProxy {
  final HomeStateCubit _value;

  const _$HomeStateCubitCWProxyImpl(this._value);

  @override
  HomeStateCubit averagePriceModel(AveragePriceModel? averagePriceModel) =>
      this(averagePriceModel: averagePriceModel);

  @override
  HomeStateCubit chartPrices(List<double>? chartPrices) =>
      this(chartPrices: chartPrices);

  @override
  HomeStateCubit error(DioError? error) => this(error: error);

  @override
  HomeStateCubit loading(bool loading) => this(loading: loading);

  @override
  HomeStateCubit minAndMax(MinAndMaxModel? minAndMax) =>
      this(minAndMax: minAndMax);

  @override
  HomeStateCubit priceList(List<PriceModel> priceList) =>
      this(priceList: priceList);

  @override
  HomeStateCubit prices(Map<String, PriceModel> prices) => this(prices: prices);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HomeStateCubit(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HomeStateCubit(...).copyWith(id: 12, name: "My name")
  /// ````
  HomeStateCubit call({
    Object? averagePriceModel = const $CopyWithPlaceholder(),
    Object? chartPrices = const $CopyWithPlaceholder(),
    Object? error = const $CopyWithPlaceholder(),
    Object? loading = const $CopyWithPlaceholder(),
    Object? minAndMax = const $CopyWithPlaceholder(),
    Object? priceList = const $CopyWithPlaceholder(),
    Object? prices = const $CopyWithPlaceholder(),
  }) {
    return HomeStateCubit(
      averagePriceModel: averagePriceModel == const $CopyWithPlaceholder()
          ? _value.averagePriceModel
          // ignore: cast_nullable_to_non_nullable
          : averagePriceModel as AveragePriceModel?,
      chartPrices: chartPrices == const $CopyWithPlaceholder()
          ? _value.chartPrices
          // ignore: cast_nullable_to_non_nullable
          : chartPrices as List<double>?,
      error: error == const $CopyWithPlaceholder()
          ? _value.error
          // ignore: cast_nullable_to_non_nullable
          : error as DioError?,
      loading: loading == const $CopyWithPlaceholder() || loading == null
          ? _value.loading
          // ignore: cast_nullable_to_non_nullable
          : loading as bool,
      minAndMax: minAndMax == const $CopyWithPlaceholder()
          ? _value.minAndMax
          // ignore: cast_nullable_to_non_nullable
          : minAndMax as MinAndMaxModel?,
      priceList: priceList == const $CopyWithPlaceholder() || priceList == null
          ? _value.priceList
          // ignore: cast_nullable_to_non_nullable
          : priceList as List<PriceModel>,
      prices: prices == const $CopyWithPlaceholder() || prices == null
          ? _value.prices
          // ignore: cast_nullable_to_non_nullable
          : prices as Map<String, PriceModel>,
    );
  }
}

extension $HomeStateCubitCopyWith on HomeStateCubit {
  /// Returns a callable class that can be used as follows: `instanceOfHomeStateCubit.copyWith(...)` or like so:`instanceOfHomeStateCubit.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$HomeStateCubitCWProxy get copyWith => _$HomeStateCubitCWProxyImpl(this);
}
