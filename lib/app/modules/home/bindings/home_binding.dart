import 'package:get/get.dart';
import 'package:pawmatch/app/modules/home/controllers/home_controller.dart';
import 'package:pawmatch/app/modules/home/controllers/petfinder_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<PetfinderController>(() => PetfinderController());
  }
}
