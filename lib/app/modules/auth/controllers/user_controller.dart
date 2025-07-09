import 'package:get/get.dart';
import 'package:pawmatch/app/data/models/user_model.dart';
import 'package:pawmatch/app/modules/auth/controllers/auth_controller.dart';
import 'package:pawmatch/app/modules/auth/services/user_service.dart';

class UserController extends GetxController {
  final UserService userService;

  UserController({required this.userService});

  final Rx<User> _user = User().obs;

  User get user => _user.value;

  set user(User value) => _user.value = value;

  void clear() {
    _user.value = User();
  }

  Future<bool> createNewUser(User user) async {
    return await userService.createNewUser(user);
  }

  Future<User> getUser(String uid) async {
    return await userService.getUser(uid);
  }
}
