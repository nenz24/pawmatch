import 'package:get/get.dart';
import 'package:pawmatch/app/modules/home/views/menu.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  @override
  void onInit() {
    super.onInit();

    // Auto-navigate ke /home setelah delay
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAll(MenuView());
    });
  }
}
