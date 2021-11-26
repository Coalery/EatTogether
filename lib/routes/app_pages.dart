import 'package:eat_together/bindings/home.binding.dart';
import 'package:eat_together/modules/home/home.page.dart';
import 'package:eat_together/routes/app_routes.dart';
import 'package:get/get.dart';

class Pages {
  static final pages = [
    GetPage(
      name: Routes.initial,
      page: () => HomePage(),
      binding: HomeBinding()
    )
  ];
}