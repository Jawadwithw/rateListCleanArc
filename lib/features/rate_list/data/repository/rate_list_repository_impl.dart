import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/rate_list.dart';
import '../../domain/repository/rate_list_repository.dart';
import '../datasources/rate_list_local_datasource.dart';
import '../datasources/rate_list_remote_datasource.dart';
import '../models/last_ratelist_time_model.dart';

class RateListRepositoryImpl implements RateListRepository {
  final RateListRemoteDataSource remoteDataSource;
  final RateListLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  RateListRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});
  @override
  Future<Either<Failure, RateList>> getRateList() async {
    if (await networkInfo.isConnected) {
      print("here net");

      try {
        final remoteRateList = await remoteDataSource.getRateList();
        localDataSource.cacheRateList(remoteRateList);
        localDataSource.cacheLastRateListTime(
            LastRatelistTimeModel(lastTime: DateTime.now()));
        return Right(remoteRateList);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      print("no net");
      try {
        final localRateList = await localDataSource.getLastCachedRateList();
        return Right(localRateList);
      } catch (e) {
        return Left(CacheFailure());
      }
    }
  }
  
  @override
  Future<Either<Failure, String>> getLastRateListTime() async {
  try {
      final lastRatelistTime = await localDataSource.getLastRatelistTime();
      return Right(lastRatelistTime);
    } catch (e) {
      return Left(CacheFailure());
    }
  }


}
