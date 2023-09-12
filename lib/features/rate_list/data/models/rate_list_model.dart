import 'rate_model.dart';
import '../../domain/entities/rate_list.dart';

class RateListModel extends RateList {
  const RateListModel({required super.list});

  factory RateListModel.getRateList(Map<String, dynamic> payLoadList) {
    List<RateModel> finalList = [];

    for (var element in payLoadList['rates']) {
      finalList.add(RateModel.fromJson(element));
    }
    return RateListModel(list: finalList);
  }

  Map<String, dynamic> toJson() {
    List<dynamic> rateList = [];
    for (var element in list) {
      rateList.add({'symbol': element.symbol, 'price': element.price});
    }
    return {'rates': rateList};
  }
}
