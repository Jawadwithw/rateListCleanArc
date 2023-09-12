import 'dart:convert';

import '../models/last_ratelist_time_model.dart';

import '../../../../core/error/exceptions.dart';
import '../models/rate_list_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

abstract class RateListLocalDataSource {
  Future<void> cacheRateList(RateListModel rateModelList);
  Future<void> cacheLastRateListTime(LastRatelistTimeModel lastTime);
  Future<RateListModel> getLastCachedRateList();
  Future<String> getLastRatelistTime();
}

const CACHED_RATE_LIST = 'CACHED_RATE_LIST';
const LAST_RATELIST_TIME = 'LAST_RATELIST_TIME';

class RateListLocalDataSourceImpl implements RateListLocalDataSource {
  final SharedPreferences sharedPreferences;

  RateListLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheRateList(RateListModel rateModelList) {
    return sharedPreferences.setString(
        CACHED_RATE_LIST, json.encode(rateModelList.toJson()));
  }

  @override
  Future<RateListModel> getLastCachedRateList() {
    final jsonString = sharedPreferences.getString(CACHED_RATE_LIST);
    if (jsonString != null) {
      return Future.value(RateListModel.getRateList(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<String> getLastRatelistTime() {
    final jsonString = sharedPreferences.getString(LAST_RATELIST_TIME);
    if (jsonString != null) {
      return Future.value(jsonString);
    } else {
      return Future.value('');
    }
  }

  @override
  Future<void> cacheLastRateListTime(LastRatelistTimeModel lastTimeModel) {
    return sharedPreferences.setString(
        LAST_RATELIST_TIME, lastTimeModel.convertDateToString());
  }
}
