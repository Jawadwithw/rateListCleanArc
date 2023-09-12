import 'package:equatable/equatable.dart';

class Rate extends Equatable {
  final String symbol;
  final double price;

  const Rate({required this.symbol, required this.price});
  @override
  List<Object?> get props => [symbol, price];
}
