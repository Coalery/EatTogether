import 'package:eat_together/common/initialize.dart';
import 'package:eat_together/global/auth.controller.dart';
import 'package:eat_together/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    AppInitialize().initialize().then(
      (_) {
        if(Get.find<AuthController>().isLogin) {
          Get.offAndToNamed(Routes.home);
        } else {
          Get.offAndToNamed(Routes.login);
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Color(0xFF9AD3BC),
      padding: EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/logo_transparent.png',
            width: 300,
          ),
          SizedBox(height: 80),
          CircularProgressIndicator()
        ]
      )
    );
  }
}