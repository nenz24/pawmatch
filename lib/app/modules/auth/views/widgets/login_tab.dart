import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawmatch/app/modules/auth/controllers/auth_controller.dart';

class LoginTab extends StatelessWidget {
  AuthController authC = Get.put(AuthController());
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
              child: TabBar(
            controller: authC.controller,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: authC.myTabs,
          ))),
      body: TabBarView(controller: authC.controller, children: [
        Tab(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                autocorrect: false,
                controller: authC.nameC,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent)),
                    labelText: 'Username / Email',
                    prefixIcon: Icon(Icons.person)),
              ),
              SizedBox(height: 10),
              Obx(() => TextField(
                    autocorrect: false,
                    controller: authC.passwordC,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueAccent)),
                        labelText: 'Password',
                        suffixIcon: IconButton(
                            onPressed: () => authC.togglePasswordVisibility(),
                            icon: authC.isHiddenPassword.value
                                ? Icon(Icons.visibility_off_outlined)
                                : Icon(Icons.visibility_outlined)),
                        prefixIcon: Icon(Icons.key_outlined)),
                    obscureText: authC.isHiddenPassword.value,
                  )),
            ],
          ),
        )),
        Tab(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                autocorrect: false,
                controller: authC.nameC,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent)),
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.person)),
              ),
              SizedBox(height: 10),
              TextField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                controller: authC.emailC,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent)),
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.person)),
              ),
              SizedBox(height: 10),
              TextField(
                autocorrect: false,
                controller: authC.phoneC,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent)),
                    labelText: 'Telp',
                    prefixIcon: Icon(Icons.phone_outlined)),
              ),
              SizedBox(height: 10),
              Obx(() => TextField(
                    autocorrect: false,
                    controller: authC.passwordC,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueAccent)),
                        labelText: 'Password',
                        suffixIcon: IconButton(
                            onPressed: () => authC.togglePasswordVisibility(),
                            icon: authC.isHiddenPassword.value
                                ? Icon(Icons.visibility_off_outlined)
                                : Icon(Icons.visibility_outlined)),
                        prefixIcon: Icon(Icons.key_outlined)),
                    obscureText: authC.isHiddenPassword.value,
                  )),
              SizedBox(height: 10),
              Obx(() => TextField(
                    autocorrect: false,
                    controller: authC.confirmPasswordC,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueAccent)),
                        labelText: 'Confirm Password',
                        suffixIcon: IconButton(
                            onPressed: () =>
                                authC.toggleConfirmPasswordVisibility(),
                            icon: authC.isHiddenConfirmPassword.value
                                ? Icon(Icons.visibility_off_outlined)
                                : Icon(Icons.visibility_outlined)),
                        prefixIcon: Icon(Icons.key_outlined)),
                    obscureText: authC.isHiddenConfirmPassword.value,
                  )),
            ],
          ),
        ))
      ]),
    );
  }
}
