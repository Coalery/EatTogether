import 'package:eat_together/global/auth.controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class AppInitialize {
  Future<void> initialize() async {
    await Firebase.initializeApp();
    Get.put(AuthController()).initialize();
  }
}