import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:randomuser/service/connection/base_connection_service.dart';

class ConnectionService implements BaseConnectionService {
  ///SingleTon
  ConnectionService._privateConstructor();

  static final ConnectionService _instance =
      ConnectionService._privateConstructor();

  factory ConnectionService({required Connectivity connectivity}) {
    _instance.connectivity = connectivity;
    return _instance;
  }

  late Connectivity connectivity;

  @override
  Future<ConnectivityResult> getStatus() async {
    return connectivity.checkConnectivity();
  }

  @override
  Stream<ConnectivityResult> listenGetStatus() async* {
    yield* connectivity.onConnectivityChanged;
  }
}
