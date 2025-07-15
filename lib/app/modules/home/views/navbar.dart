import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawmatch/app/modules/home/controllers/home_controller.dart';
import 'package:pawmatch/app/modules/home/views/Profile.dart';
import 'package:pawmatch/app/modules/home/views/menu.dart';

import 'product_list_view.dart'; // nanti akan gunakan ini untuk menampilkan API product

class NavbarView extends StatelessWidget {
  const NavbarView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller =
        Get.put(HomeController(), permanent: true);

    final List<Widget> pages = [
      const FirstView(),
      ProductListView(), // nanti ini berisi produk dari API
      const ProfileScreen(),
    ];

    return Obx(() => Scaffold(
          body: IndexedStack(
            index: controller.selectedIndex.value,
            children: pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.selectedIndex.value,
            onTap: controller.changePage,
            selectedItemColor: Colors.lightBlue,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.pets), label: 'Animals'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
        ));
  }
}
