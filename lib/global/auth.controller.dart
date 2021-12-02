import 'dart:async';

import 'package:eat_together/data/model/user.model.dart' as u;
import 'package:eat_together/data/provider/api_client.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxnString token = RxnString();
  Rxn<u.User> me = Rxn<u.User>();

  Future<void> initialize() async {
    Completer<void> firstRequestFinished = Completer();
    FirebaseAuth.instance.authStateChanges().listen((gfUser) async {
      if(gfUser == null) return;
      String token = await gfUser.getIdToken();
      this.token(token);
      print(token);

      dynamic response = await ApiClient().get('/user');
      me(u.User.fromJson(response['data']));
      
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