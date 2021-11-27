import 'package:eat_together/bindings/home.binding.dart';
import 'package:eat_together/bindings/login.binding.dart';
import 'package:eat_together/modules/home/home.page.dart';
import 'package:eat_together/modules/login/login.page.dart';
import 'package:eat_together/routes/app_routes.dart';
import 'package:get/get.dart';

class Pages {
  static final pages = [
    GetPage(
      name: Routes.login,
      page: () => LoginPage(),
      binding: LoginBinding()
    ),
    GetPage(
      name: Routes.home,
      page: () => HomePage(),
      binding: HomeBinding()
    )
  ];
}