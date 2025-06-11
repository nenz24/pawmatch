import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController with SingleGetTickerProviderMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Masuk'),
    Tab(text: 'Daftar'),
  ];
  late TabController controller;
  @override
  void onInit() {
    super.onInit();
    controller = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }

  RxBool isHiddenPassword = true.obs;
  RxBool isHiddenConfirmPassword = true.obs;

  TextEditingController nameC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController confirmPasswordC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  late TabController tabC = TabController(length: 2, vsync: ScrollableState());

  void togglePasswordVisibility() {
    isHiddenPassword.value = !isHiddenPassword.value;
    update();
  }

  void toggleConfirmPasswordVisibility() {
    isHiddenConfirmPassword.value = !isHiddenConfirmPassword.value;
    update();
  }
}
