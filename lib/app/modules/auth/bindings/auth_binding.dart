import 'package:get/get.dart';
import 'package:pawmatch/app/modules/auth/controllers/user_controller.dart';
import 'package:pawmatch/app/modules/auth/services/auth_service.dart';
import 'package:pawmatch/app/modules/auth/services/user_service.dart';

import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    await Get.putAsync<AuthController>(
        () async => AuthController(authService: AuthService()),
        permanent: true);
    Get.put<UserController>(UserController(userService: UserService()),
        permanent: true);
  }
}
