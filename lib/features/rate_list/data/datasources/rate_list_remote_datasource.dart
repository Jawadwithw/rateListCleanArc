import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/constants/endpoint_provider.dart';
import '../../../../core/constants/url_provider.dart';
import '../../../../core/error/exceptions.dart';
import '../models/rate_list_model.dart';

abstract class RateListRemoteDataSource {
  Future<RateListModel> getRateList();
}

class RateListRemoteDataSourceImpl implements RateListRemoteDataSource {
  final Dio dio;

  RateListRemoteDataSourceImpl({required this.dio});

  @override
  Future<RateListModel> getRateList() async {
    try {
      final response = await dio
          .get(URLProvider.productionBaseURL + EndPointProvider.getRateList);

      if (response.statusCode == 200) {
        return RateListModel.getRateList(json.decode(response.data));
      } else {

        throw ServerException();
      }
    } catch (e) {
      print(e);

      throw ServerException();
    }
  }
}
