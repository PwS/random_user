import 'package:randomuser/models/user/user.dart';
import 'package:randomuser/service/config/dio_client.dart';
import 'package:randomuser/service/user/base_user_service.dart';

class UserService implements BaseUserService {
  ///SingleTon
  UserService._privateConstructor();

  static final UserService _instance = UserService._privateConstructor();

  factory UserService() {
    return _instance;
  }

  final DioClient _client = DioClient();

  @override
  Future<User> getUser() async {
    User dataUser = const User();
    try {
      final response =
          await _client.getRequest('https://random-data-api.com/api/v2/users');
      if (response.statusCode == 200) {
        final result = User.fromJson(response.data);
        if (result == User.empty) {
          return dataUser;
        }
        dataUser = result;
      }
      return dataUser;
    } catch (e, s) {
      throw Exception('Catch Exception $e on StackTrace $s');
    }
  }
}
