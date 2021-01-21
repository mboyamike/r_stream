import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:r_stream/widgets/authenticator.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  final Rx<User> _user = Rx<User>();

  get user => _user.value;

  set user(User user) => _user.value = user;

  AuthController() {
    _user.bindStream(auth.authStateChanges());
  }

  void createUserWithEmailAndPassword({String email, String password}) async {
    try {
      await auth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .whenComplete(() => Get.offAll(Authenticator()));
    } catch (e) {
      Get.snackbar("Error Creating user", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void signInWithEmailAndPassword({String email, String password}) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.offAll(Authenticator());
    } catch (e) {
      Get.snackbar("Error Signing in", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void signOut() async {
    await auth.signOut();
    Get.offAll(Authenticator());
  }
}
