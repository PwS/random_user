import 'package:randomuser/models/user/user.dart';

abstract class BaseHiveService {
  ///User
  Future<User> getUser();
  Future<List<User>> getAllUserOnBox();

  Future<bool> replaceUser(User user);

  Future<void> deleteAllUser();
}
