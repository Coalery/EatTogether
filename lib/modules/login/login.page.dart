import 'package:eat_together/modules/login/login.controller.dart';
import 'package:eat_together/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
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
              TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/ic_google.jpg',
                        height: 50,
                      )
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          '구글 계정으로 로그인',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16
                          )
                        ),
                      ),
                    )
                  ]
                ),
                onPressed: () async {
                  bool isSuccess = await controller.trySignInWithGoogle();
                  if(isSuccess) Get.toNamed(Routes.home);
                },
              )
            ]
          )
        )
      )
    );
  }
}