import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  RxnString token = RxnString();

  bool initialize() {
    FirebaseAuth.instance.authStateChanges().listen((gfUser) async {
      if(gfUser == null) return;
      String token = await gfUser.getIdToken();
      this.token(token);
    });

    return true;
  }

  Future<bool> trySignInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if(googleUser == null) return false;

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final OAuthCredential googleCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );

    await FirebaseAuth.instance.signInWithCredential(googleCredential);
    return true;
  }
}