import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnection {
  Stream<ConnectivityResult> connectionStream =
      Connectivity().onConnectivityChanged;
  late StreamSubscription<ConnectivityResult> connectionSubcription;
  late bool isConnected;

  InternetConnection() {
    connectionSubcription = connectionStream.listen((event) {
      if ((event == ConnectivityResult.none) ||
          (event == ConnectivityResult.bluetooth) ||
          (event == ConnectivityResult.ethernet)) {
        isConnected = false;
      } else {
        isConnected = true;
      }
    });
  }
}
