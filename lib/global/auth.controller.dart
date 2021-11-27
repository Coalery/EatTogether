import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxnString token = RxnString();

  Future<void> initialize() async {
    Completer<void> firstRequestFinished = Completer();
    FirebaseAuth.instance.authStateChanges().listen((gfUser) async {
      if(gfUser == null) return;
      String token = await gfUser.getIdToken();
      this.token(token);
      print(token);
      
      if(!firstRequestFinished.isCompleted) {
        firstRequestFinished.complete();
      }
    });
    await firstRequestFinished.future.timeout(
      Duration(seconds: 1),
      onTimeout: () {}
    );
  }

  bool get isLogin => token.value != null;
}