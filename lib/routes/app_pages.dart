import 'package:eat_together/modules/splash/splash.page.dart';
import 'package:eat_together/routes/app_routes.dart';
import 'package:get/get.dart';

class Pages {
  static final pages = [
    GetPage(name: Routes.initial, page: () => SplashPage())
  ];
}