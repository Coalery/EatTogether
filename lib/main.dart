import 'package:eat_together/common/initialize.dart';
import 'package:eat_together/routes/app_pages.dart';
import 'package:eat_together/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInitialize().initialize();
  runApp(EatTogetherApp());
}

class EatTogetherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.login,
      getPages: Pages.pages,
    );
  }
}

