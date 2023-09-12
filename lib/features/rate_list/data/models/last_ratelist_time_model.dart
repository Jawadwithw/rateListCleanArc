import '../../domain/entities/last_ratelist_time.dart';
import 'package:intl/intl.dart';

class LastRatelistTimeModel extends LastRatelistTime {
  const LastRatelistTimeModel({required super.lastTime});


  String convertDateToString() {
    return DateFormat('yyyy-MM-dd – kk:mm').format(lastTime);
    
  }
}
