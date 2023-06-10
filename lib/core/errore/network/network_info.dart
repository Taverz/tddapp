
import 'package:flutter_network_connectivity/flutter_network_connectivity.dart';

abstract class NetworkInfo {
  Future<bool> get isConnect;
}


class NetworkinfoImpl implements NetworkInfo {
  final FlutterNetworkConnectivity connectionChecker;

  NetworkinfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnect {
    // TODO: implement isConnect
    throw UnimplementedError();
  }
}