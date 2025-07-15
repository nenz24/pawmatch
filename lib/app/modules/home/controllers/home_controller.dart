import 'package:get/get.dart';
import 'package:pawmatch/app/modules/home/models/petfinder_model.dart'
    as models;
import 'package:pawmatch/app/modules/home/views/menu.dart';

class HomeController extends GetxController {
  var animals = <models.Animal>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAnimals();
  }

  void fetchAnimals() async {
    try {
      isLoading(true);
      // Ganti ini dengan pemanggilan API kamu
      final result = await Future.delayed(const Duration(seconds: 2), () {
        return [
          models.Animal(
              name: 'Lucky',
              breeds: models.Breeds(primary: 'Golden Retriever'),
              photos: [],
              id: 1),
          models.Animal(
              name: 'Whiskers',
              breeds: models.Breeds(primary: 'Persian Cat'),
              photos: [],
              id: 2)
        ];
      });
      animals.value = result;
    } catch (e) {
      // Handle error
    } finally {
      isLoading(false);
    }
  }

  Future<void> initializeApp() async {
    await Future.delayed(Duration(seconds: 3)); // simulasi fetch data
  }

  // Menyimpan index halaman yang sedang aktif
  var selectedIndex = 0.obs;

  // Mengganti halaman berdasarkan index
  void changePage(int index) {
    selectedIndex.value = index;
  }
}
