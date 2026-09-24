import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:randomuser/models/user/user.dart';
import 'package:randomuser/service/connection/connection_service.dart';
import 'package:randomuser/service/local_database/hive/hive_service.dart';
import 'package:randomuser/service/user/user_service.dart';

///In-memory replacement for Hive, so tests do not touch the disk
class FakeHiveService implements HiveService {
  FakeHiveService([this.cachedUser = User.empty]);

  User cachedUser;
  int deleteCount = 0;

  @override
  Future<User> getUser() async => cachedUser;

  @override
  Future<List<User>> getAllUserOnBox() async =>
      cachedUser == User.empty ? [] : [cachedUser];

  @override
  Future<bool> replaceUser(User user) async {
    cachedUser = user;
    return true;
  }

  @override
  Future<void> deleteAllUser() async {
    deleteCount++;
    cachedUser = User.empty;
  }
}

///Returns a fixed user instead of calling the API
class FakeUserService implements UserService {
  FakeUserService(this.userFromApi);

  final User userFromApi;
  int callCount = 0;

  @override
  Future<User> getUser() async {
    callCount++;
    return userFromApi;
  }
}

///Lets a test push connection changes by hand
class FakeConnectionService implements ConnectionService {
  final StreamController<ConnectivityResult> controller =
      StreamController<ConnectivityResult>.broadcast();

  @override
  late Connectivity connectivity;

  @override
  Future<ConnectivityResult> getStatus() async => ConnectivityResult.none;

  @override
  Stream<ConnectivityResult> listenGetStatus() => controller.stream;
}
