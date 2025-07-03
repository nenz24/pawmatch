import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController with SingleGetTickerProviderMixin {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late TabController tabController;
  RxBool isHidden = true.obs;
  RxBool rememberMe = false.obs;

  void login() async {
    final box = GetStorage();
    if (emailController.text == 'admin@gmail.com' ||
        passwordController.text == 'admin') {
      if (box.read('dataRememberMe') != null) {
        box.remove('dataRememberMe');
      }
      if (rememberMe.isTrue) {
        box.write('dataRememberMe', {
          'email': emailController.text,
          'password': passwordController.text
        });
      }
    }
    Get.toNamed('/home'); // Navigate to home page after login
    // Implement login logic here
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please fill in all fields');
      return;
    }

    // Simulate a successful login
    Get.snackbar('Success', 'Logged in successfully');
  }

  void rememberME() {
    rememberMe.value = !rememberMe.value;
  }

  void togglePasswordVisibility() {
    isHidden.value = !isHidden.value;
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
