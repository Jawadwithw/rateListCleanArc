import 'package:equatable/equatable.dart';

class LastRatelistTime extends Equatable {
  final DateTime lastTime;

  const LastRatelistTime({required this.lastTime});
  @override
  List<Object?> get props => [lastTime];
}
