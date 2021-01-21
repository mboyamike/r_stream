import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:r_stream/controllers/auth_controller.dart';
import 'package:r_stream/screens/home_page.dart';
import 'package:r_stream/screens/sign_in_page.dart';

class Authenticator extends StatelessWidget {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => authController.user == null ? SignInPage() : HomePage());
  }
}
