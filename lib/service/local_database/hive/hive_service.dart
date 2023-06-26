import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:randomuser/db/db_hive/box_name.dart';
import 'package:randomuser/models/user/user.dart';
import 'package:randomuser/service/local_database/hive/base_hive_service.dart';

class HiveService implements BaseHiveService {
  ///SingleTon
  HiveService._privateConstructor();

  static final HiveService _instance = HiveService._privateConstructor();

  factory HiveService() {
    return _instance;
  }

  @override
  Future<User> getUser() async {
    try {
      final Box userBox = await Hive.openBox(BoxName.boxUser);
      if (userBox.isEmpty) {
        return User.empty;
      }
      return userBox.values.first;
    } catch (_) {
      throw Exception('Failed Get Data User / Open Box User');
    }
  }

  @override
  Future<List<User>> getAllUserOnBox() async {
    try {
      final Box userBox = await Hive.openBox(BoxName.boxUser);
      if (userBox.isEmpty) {
        return [];
      }
      List<dynamic> resultDynamic = userBox.values.toList();
      final List<User> result = resultDynamic.cast<User>();
      return result;
    } catch (_) {
      throw Exception('Failed Get All Data User / Open Box User');
    }
  }

  @override
  Future<bool> replaceUser(User user) async {
    try {
      final Box userBox = await Hive.openBox(BoxName.boxUser);
      await userBox.put(user.id, user);
      return true;
    } catch (_) {
      throw Exception('Failed Save Data User / Open Box Data User');
    }
  }

  @override
  Future<void> deleteAllUser() async {
    try {
      final Box userBox = await Hive.openBox(BoxName.boxUser);
      await userBox.deleteFromDisk();
    } catch (err) {
      debugPrint('Something went wrong when deleting an item: $err');
    }
  }
}
