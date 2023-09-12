import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'core/network/network_info.dart';
import 'features/rate_list/data/datasources/rate_list_local_datasource.dart';
import 'features/rate_list/data/datasources/rate_list_remote_datasource.dart';
import 'features/rate_list/data/repository/rate_list_repository_impl.dart';
import 'features/rate_list/domain/repository/rate_list_repository.dart';
import 'features/rate_list/domain/usecase/rate_list_usecase.dart';
import 'features/rate_list/presentation/bloc/bloc/ratelist_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
Future<void> init() async {
  print('initig1');
  //Bloc
  sl.registerFactory(() => RatelistBloc(rateListUseCase: sl()));

  //use cases
  sl.registerLazySingleton(() => RateListUseCase(rateListRepository: sl()));

  //repository
  sl.registerLazySingleton<RateListRepository>(() => RateListRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  //datasource
  sl.registerLazySingleton<RateListRemoteDataSource>(
      () => RateListRemoteDataSourceImpl(dio: sl()));
  sl.registerLazySingleton<RateListLocalDataSource>(
      () => RateListLocalDataSourceImpl(sharedPreferences: sl()));

  //core
  sl.registerLazySingleton<NetworkInfo>(() => NetwrokInfoImpl(sl()));

  //external
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => DataConnectionChecker());
    print('initig2');

}
