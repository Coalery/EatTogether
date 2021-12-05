import 'package:eat_together/data/provider/api_client.dart';
import 'package:eat_together/data/repository/party.repository.dart';
import 'package:eat_together/modules/create_party/create_party.controller.dart';
import 'package:get/get.dart';

class CreatePartyBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CreatePartyController(partyRepository: PartyRepository(client: ApiClient())));
  }
}