class MinMaxPrice {
  String? date;
  String? hour;
  bool? isCheap;
  bool? isUnderAvg;
  String? market;
  double? price;
  String? units;

  MinMaxPrice(
      {this.date,
      this.hour,
      this.isCheap,
      this.isUnderAvg,
      this.market,
      this.price,
      this.units});

  MinMaxPrice.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    hour = json['hour'];
    isCheap = json['is-cheap'];
    isUnderAvg = json['is-under-avg'];
    market = json['market'];
    price = json['price'];
    units = json['units'];
  }

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