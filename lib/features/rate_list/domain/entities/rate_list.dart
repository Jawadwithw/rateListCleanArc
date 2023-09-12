import 'package:equatable/equatable.dart';
import 'rate.dart';

class RateList extends Equatable {
  final List<Rate> list;

  const RateList({required this.list});

  @override
  List<Object?> get props => [list];
}
