import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../domain/entities/rate_list.dart';
import '../../../domain/usecase/rate_list_usecase.dart';

import '../../../../../core/error/failure.dart';

part 'ratelist_event.dart';
part 'ratelist_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class RatelistBloc extends Bloc<RatelistEvent, RatelistState> {
  final RateListUseCase rateListUseCase;

  RatelistBloc({required this.rateListUseCase}) : super(Loading()) {
    on<GetRateList>(_onRateListEvent);
    on<GetLastRatelistTime>(_onLastRatlistEvent);
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;

      default:
        return 'Unexpected error';
    }
  }

  void _onRateListEvent(GetRateList event, Emitter<RatelistState> emit) async {
    emit(Loading());
    final failureOrRatelist = await rateListUseCase(NoParams());
    emit(failureOrRatelist.fold((failure) {
      return Error(message: _mapFailureToMessage(failure));
    }, (rateList) {
      print(rateList);
      return Loaded(rateList: rateList);
    }));
  }

  FutureOr<void> _onLastRatlistEvent(
      GetLastRatelistTime event, Emitter<RatelistState> emit) {}
}
