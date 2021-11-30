import 'package:eat_together/data/provider/api_client.dart';
import 'package:eat_together/data/repository/party.repository.dart';
import 'package:eat_together/modules/party/party.controller.dart';
import 'package:get/get.dart';

class PartyBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      PartyController(partyRepository: PartyRepository(client: ApiClient()))
    );
  }
}