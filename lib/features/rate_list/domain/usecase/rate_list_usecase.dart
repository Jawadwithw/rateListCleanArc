import 'package:dartz/dartz.dart';
import '../entities/rate_list.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/rate_list_repository.dart';

class RateListUseCase implements UseCase<RateList, NoParams> {
  final RateListRepository rateListRepository;

  RateListUseCase({required this.rateListRepository});

  @override
  Future<Either<Failure, RateList>> call(NoParams params) async {
    return await rateListRepository.getRateList();
  }
}
