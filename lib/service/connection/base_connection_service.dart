import 'package:connectivity_plus/connectivity_plus.dart';

abstract class BaseConnectionService {
  Future<ConnectivityResult> getStatus();

  Stream<ConnectivityResult> listenGetStatus();
}
