import 'package:eat_together/common/constant.dart';
import 'package:eat_together/initialize/initialize.dart';
import 'package:eat_together/global/auth.controller.dart';
import 'package:eat_together/initialize/initialize_failed.exception.dart';
import 'package:eat_together/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  InitializeFailType? type;

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
    ).catchError((e) {
      final exception = e as InitializeFailedException;
      setState(() { type = exception.type; });
    }, test: (exception) {
      if(exception is! InitializeFailedException) return false;
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Constant.mainColor,
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
            _InitializeStatus(type: type)
          ]
        )
      ),
    );
  }
}

class _InitializeStatus extends StatelessWidget {
  final InitializeFailType? type;

  _InitializeStatus({required this.type});

  @override
  Widget build(BuildContext context) {
    if(type == null) return CircularProgressIndicator();

    return Text(
      type!.message,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 18
      ),
    );
  }
}