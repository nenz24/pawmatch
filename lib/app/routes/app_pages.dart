import 'package:get/get.dart';
import 'package:pawmatch/app/modules/auth/views/signin_view.dart';
import 'package:pawmatch/app/modules/home/controllers/home_controller.dart';
import 'package:pawmatch/app/modules/home/views/loading_view.dart';
import 'package:pawmatch/app/modules/onboarding/views/splash_screen_view.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ONBOARDING;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: BindingsBuilder(() {
        Get.put(HomeController());
      }),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const SplashScreenView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => SigninView(),
      binding: AuthBinding(),
    ),
  ];
}
