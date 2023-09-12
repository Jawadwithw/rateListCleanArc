import '../../domain/entities/rate.dart';

class RateModel extends Rate {
  const RateModel({required super.symbol, required super.price});

  factory RateModel.fromJson(Map<String, dynamic> json) {
    return RateModel(symbol: json['symbol'], price: json['price']);
  }


  Map<String, dynamic> toJson() {
    return {'symbol': symbol, 'price': price};
  }

}
