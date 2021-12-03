import 'package:eat_together/modules/create_party/create_party.controller.dart';
import 'package:get/get.dart';

class CreatePartyBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CreatePartyController());
  }
}