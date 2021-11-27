import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxnString token = RxnString();

  bool initialize() {
    FirebaseAuth.instance.authStateChanges().listen((gfUser) async {
      if(gfUser == null) return;
      String token = await gfUser.getIdToken();
      this.token(token);
    });

    return true;
  }
}