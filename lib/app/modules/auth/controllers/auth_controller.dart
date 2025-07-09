import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart' as fauth;
import 'package:get_storage/get_storage.dart';
import 'package:pawmatch/app/data/models/user_model.dart';
import 'package:pawmatch/app/modules/auth/controllers/user_controller.dart';
import 'package:pawmatch/app/modules/auth/services/auth_service.dart';
import 'package:pawmatch/app/routes/app_pages.dart';

class AuthController extends GetxController {
  final AuthService authService;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RxBool RememberMe = false.obs;
  RxBool isHidden = false.obs;

  void setRememberMe() {
    final box = GetStorage();
    if (RememberMe.isTrue) {
      box.write('dataRememberMe',
          {'email': emailController.text, 'password': passwordController.text});
    } else {
      GetStorage().remove('dataRememberMe');
    }
  }

  AuthController({required this.authService});

  final Rx<fauth.User?> _firebaseUser =
      Rx<fauth.User?>(fauth.FirebaseAuth.instance.currentUser);

  fauth.User? get user => _firebaseUser.value;

  @override
  onInit() {
    _firebaseUser.bindStream(authService.authStateChanges());
    super.onInit();
  }

  void clear() {
    _firebaseUser.value = null;
  }

  Future<void> createUser(String name, String email, String password) async {
    try {
      fauth.UserCredential authResult =
          await authService.createUser(name, email, password);

      if (authResult.user == null) {
        throw Exception('authResult.user == null');
      }

      _firebaseUser.value = authResult.user;

      User user = User(
        id: authResult.user!.uid,
        name: name,
        email: authResult.user!.email,
      );
      final userController = Get.find<UserController>();
      if (await userController.createNewUser(user)) {
        userController.user = user;
        Get.offAllNamed(Routes.HOME);
      } else {
        throw Exception('user was not created.');
      }
    } catch (e) {
      Get.snackbar(
        "Error creating Account",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      e.printError();
    }
  }

  Future<void> login(String email, String password) async {
    try {
      fauth.UserCredential authResult =
          await authService.login(email, password);

      _firebaseUser.value = authResult.user;

      final userController = Get.find<UserController>();
      userController.user = await userController.getUser(authResult.user!.uid);
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      Get.snackbar(
        "Error signing in",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      e.printError();
    }
  }

  Future<void> signOut() async {
    try {
      await authService.signOut();
      clear();
      Get.find<UserController>().clear();
      Get.offAllNamed(Routes.AUTH);
    } catch (e) {
      Get.snackbar(
        "Error signing out",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      e.printError();
    }
  }
}
