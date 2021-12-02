import 'package:eat_together/data/model/party.model.dart';
import 'package:eat_together/data/repository/party.repository.dart';
import 'package:eat_together/modules/party/amount_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PartyController extends GetxController {
  final PartyRepository partyRepository;
  Rxn<Party> party = Rxn<Party>();

  PartyController({required this.partyRepository});

  @override
  void onInit() {
    super.onInit();
    getParty();
  }

  Future<void> getParty() async {
    int partyId = Get.arguments;
    dynamic response = await partyRepository.getPartyById(partyId);
    party(Party.fromJson(response['data']));
  }

  bool get isLoading => party.value == null;

  Future<void> participate(BuildContext context) async {
    if(!party.value!.isParticipating) return;

    int? point = await showAmountSelector(context: context);
    if(point == null) return;

    await partyRepository.participate(point);
    
    await getParty();
  }
}