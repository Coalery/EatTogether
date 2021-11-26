import 'package:eat_together/data/provider/api_client.dart';
import 'package:eat_together/data/repository/party.repository.dart';
import 'package:eat_together/modules/home/home.controller.dart';
import 'package:get/get.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      HomeController(partyRepository: PartyRepository(client: ApiClient()))
    );
  }
}