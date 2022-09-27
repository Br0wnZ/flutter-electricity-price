class PriceModel {
  String? date;
  String? hour;
  bool? isCheap;
  bool? isUnderAvg;
  String? market;
  double? price;
  String? units;

  PriceModel(
      {this.date,
      this.hour,
      this.isCheap,
      this.isUnderAvg,
      this.market,
      this.price,
      this.units});
  
  factory PriceModel.fromJson(Map<String, dynamic> json) => PriceModel(
      date: json['date'] as String?,
      hour: json['hour'] as String?,
      isCheap: json['is-cheap'] as bool?,
      isUnderAvg: json['is-under-avg'] as bool?,
      market: json['market'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      units: json['units'] as String?,
    );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['hour'] = this.hour;
    data['is-cheap'] = this.isCheap;
    data['is-under-avg'] = this.isUnderAvg;
    data['market'] = this.market;
    data['price'] = this.price;
    data['units'] = this.units;
    return data;
  }
}
