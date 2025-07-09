import 'package:get/get.dart';

import '../../../data/models/user_model.dart';

class UserProvider extends GetConnect {
  @override
  Future<User?> getUser(int id) async {
    final response = await get('user/$id');
    return response.body;
  }

  Future<Response<User>> postUser(User user) async => await post('user', user);
  Future<Response> deleteUser(int id) async => await delete('user/$id');
}
