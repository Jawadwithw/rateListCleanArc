import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/rate_list.dart';

abstract class RateListRepository {
  Future<Either<Failure,RateList>> getRateList();
  Future<Either<Failure,String>> getLastRateListTime();
}
