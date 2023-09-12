import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';

import '../repository/rate_list_repository.dart';

class LastRatelistUsecase implements UseCase<String, NoParams> {
  final RateListRepository rateListRepository;

  LastRatelistUsecase({required this.rateListRepository});

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await rateListRepository.getLastRateListTime();
  }
}
