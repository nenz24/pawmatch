import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pawmatch/app/modules/auth/views/widgets/login_tab.dart';
import 'package:pawmatch/app/modules/auth/views/widgets/textfields.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 200,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Image.asset(
            'assets/images/logo.png',
            scale: 3,
            alignment: Alignment.centerLeft,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Mulailah Sekarang',
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto'),
              ),
              Text(
                'Buat akun atau masuk untuk mulai.',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins'),
              ),
              SizedBox(height: 30),
              Container(
                alignment: Alignment.center,
                height: 400,
                padding: EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                child: Image.asset(
                  'assets/images/loginimage.png',
                  fit: BoxFit.fitHeight,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 390,
                    child: Text('Berikan Mereka Rumah Penuh Cinta',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 51, 51, 51))),
                  ),
                  Container(
                    width: 300,
                    child: Text(
                      'Jadilah bagian dari perubahan kecil yang bermakna',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: const Color(0xFFADA8A8),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showModalBottomSheet<void>(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        )),
                        context: context,
                        isScrollControlled: true,
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.9,
                        ),
                        enableDrag: true,
                        builder: (BuildContext context) => SizedBox(
                          child: LoginTab(),
                        ),
                      );
                    });
                  },
                  child: Text(
                    'Mulai Sekarang',
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
