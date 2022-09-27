class Average {
  String? date;
  String? market;
  double? price;
  String? units;

  Average({this.date, this.market, this.price, this.units});

  Average.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    market = json['market'];
    price = json['price'];
    units = json['units'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['market'] = this.market;
    data['price'] = this.price;
    data['units'] = this.units;
    return data;
  }
}