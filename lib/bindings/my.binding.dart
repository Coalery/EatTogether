import 'package:eat_together/data/provider/api_client.dart';
import 'package:eat_together/data/repository/user.repository.dart';
import 'package:eat_together/modules/my/my.controller.dart';
import 'package:get/get.dart';

class MyPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MyPageController(userRepository: UserRepository(client: ApiClient())));
  }
}