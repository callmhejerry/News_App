import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnection {
  final Stream<ConnectivityResult> _connection =
      Connectivity().onConnectivityChanged;
  Stream<ConnectivityResult> get connection => _connection;
  Future<bool> isConnected() async {
    Connectivity connectivity = Connectivity();
    ConnectivityResult result = await connectivity.checkConnectivity();
    if (result == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }
}
