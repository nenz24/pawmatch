import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController with SingleGetTickerProviderMixin {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late TabController tabController;
  RxBool isHidden = true.obs;
  RxBool rememberMe = false.obs;

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
