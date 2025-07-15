import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pawmatch/app/modules/home/controllers/home_controller.dart';
import 'package:pawmatch/app/modules/home/views/loading_view.dart';
import 'package:pawmatch/app/modules/home/views/menu.dart';
import 'package:pawmatch/app/modules/home/views/navbar.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingView(); // Tampilan loading
        } else if (snapshot.hasError) {
          return Center(child: Text('Something went wrong: ${snapshot.error}'));
        } else {
          return NavbarView(); // Tampilan utama setelah loading selesai
        }
      },
    );
  }
}
