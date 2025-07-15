import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pawmatch/app/modules/auth/bindings/auth_binding.dart';
import 'package:pawmatch/app/modules/auth/controllers/auth_controller.dart';
import 'package:pawmatch/app/modules/auth/services/auth_service.dart';
import 'package:pawmatch/app/modules/home/controllers/petfinder_controller.dart';
import 'package:pawmatch/firebase_options.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    //1
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await AuthBinding().dependencies();
  Get.put(AuthController(authService: AuthService()));

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
