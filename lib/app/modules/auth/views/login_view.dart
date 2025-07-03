import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pawmatch/app/modules/auth/controllers/auth_controller.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              autocorrect: false,
              controller: controller.emailController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Obx(() => TextField(
                  autocorrect: false,
                  controller: controller.passwordController,
                  obscureText: controller.isHidden.value,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.key),
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () => controller.togglePasswordVisibility(),
                        icon: controller.isHidden.value
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                      )),
                )),
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                            value: controller.rememberMe.value,
                            onChanged: (value) => controller.rememberME),
                        Text('Remember Me'),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to forgot password page
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                )),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  textStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  side: BorderSide(color: Colors.blue, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Log In',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                  ),
                )),
            Container(
              width: double.infinity,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 16,
                children: [
                  Expanded(
                    child: Container(
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: const Color(0xFFC3C4B9),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Or',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF3C3D37),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                      letterSpacing: -0.12,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: const Color(0xFFC3C4B9),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  textStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/google.png',
                        width: 24, height: 24),
                    Text('Continue with Google',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                        )),
                  ],
                ))
          ],
        ),
      ),
    ));
  }
}
