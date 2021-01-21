import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:r_stream/controllers/auth_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:r_stream/screens/home_page.dart';
import 'package:r_stream/screens/sign_in_page.dart';
import 'package:r_stream/screens/sign_up_page.dart';
import 'package:r_stream/widgets/authenticator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: Authenticator(),
      getPages: [
        GetPage(name: '/', page: () => Authenticator()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/sign_in', page: () => SignInPage()),
        GetPage(name: '/sign_up', page: () => SignUpPage()),
      ],
    );
  }
}
