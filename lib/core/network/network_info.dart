import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}
//if we use any class, the final res will be a bool
//so here we have abstracted class for that and for implmentation
//of that we use network info,

class NetwrokInfoImpl implements NetworkInfo {
  final DataConnectionChecker? dataConnectionChecker;

  NetwrokInfoImpl(this.dataConnectionChecker);

  @override
  Future<bool> get isConnected => dataConnectionChecker!.hasConnection;
}
