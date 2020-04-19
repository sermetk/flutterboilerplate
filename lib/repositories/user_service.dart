import 'package:flutterboilerplate/core/service/api.dart';
import 'package:flutterboilerplate/core/service/service_result.dart';
import 'package:flutterboilerplate/modules/users/user_entity.dart';

class UserService {
  Future<ServiceResult<List<UserEntity>, UserEntity>> getUsers() async {
    return await ApiBuilder()
        .getAsync<List<UserEntity>, UserEntity>("posts");
  }
}
