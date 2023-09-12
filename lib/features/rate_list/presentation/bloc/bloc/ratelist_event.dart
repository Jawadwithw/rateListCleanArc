part of 'ratelist_bloc.dart';

abstract class RatelistEvent extends Equatable {
  const RatelistEvent();

  @override
  List<Object> get props => [];
}

class GetRateList extends RatelistEvent {
}

class GetLastRatelistTime extends RatelistEvent {
  
}