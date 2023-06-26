import 'package:randomuser/models/user/user.dart';

abstract class BaseUserService {
  Future<User> getUser();
}
