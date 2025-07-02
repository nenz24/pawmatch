import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pawmatch/app/modules/auth/views/login_view.dart';
import 'package:pawmatch/app/modules/auth/views/signup_view.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 100,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/logo.png',
            ),
          ),
          bottom: TabBar(
            controller: controller.tabController,
            tabs: [Text('Log In'), Text('Sign Up')],
          ),
        ),
        body: TabBarView(
          controller: controller.tabController,
          children: [
            // Login View
            LoginView(),
            // Sign Up View
            SignupView()
          ],
        ));
  }
}
