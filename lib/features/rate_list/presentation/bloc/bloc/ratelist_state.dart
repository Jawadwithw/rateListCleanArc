part of 'ratelist_bloc.dart';

sealed class RatelistState extends Equatable {
  const RatelistState();

  @override
  List<Object> get props => [];
}

class Empty extends RatelistState {}

class Loading extends RatelistState {
  int fakeLength = 4;

  Loading({this.fakeLength = 4});
}

class Loaded extends RatelistState {
  final RateList rateList;

  const Loaded({required this.rateList});
}

class Error extends RatelistState {
  final String message;
  Error({required this.message});
}
