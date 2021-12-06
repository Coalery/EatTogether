import 'package:eat_together/data/model/party.model.dart';
import 'package:eat_together/data/repository/party.repository.dart';
import 'package:eat_together/global/auth.controller.dart';
import 'package:eat_together/modules/party/amount_selector.dart';
import 'package:eat_together/routes/app_routes.dart';
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
    int partyId;
    if(party.value == null) {
      partyId = Get.arguments;
    } else {
      partyId = party.value!.id;
    }
    
    dynamic response = await partyRepository.getPartyById(partyId);
    party(Party.fromJson(response['data']));
  }

  bool get isLoading => party.value == null;

  Future<void> participate(BuildContext context) async {
    if(!party.value!.isParticipating) return;

    int? point = await showAmountSelector(context: context);
    if(point == null) return;

    await partyRepository.participate(party.value!.id, point);
    await getParty();
  }

  Future<void> agreeSuccess() async {
    final AuthController auth = Get.find<AuthController>();
    if(party.value!.isSuccessAgreed(auth.me.value!)) return;
    
    await partyRepository.agreeSuccess(party.value!.id);
    await getParty();
  }

  Future<void> sendMessage(String msgType) async {
    int diffSec = DateTime.now().difference(
      party.value!.otherMessageUsedDate ?? DateTime.now()
    ).inSeconds;

    if(diffSec < 30) {
      Get.snackbar(
        '아직 메세지를 보낼 수 없습니다.',
        '메세지는 ${30 - diffSec}초 후에 보낼 수 있습니다.',
        margin: EdgeInsets.all(8.0)
      );
      return;
    }

    print(await partyRepository.sendMessage(party.value!.id, msgType));
    await getParty();
  }

  Future<void> cancelParticipate() async {
    final AuthController auth = Get.find<AuthController>();
    if(!party.value!.isParticipated(auth.me.value!)) return;
    await partyRepository.cancelParticipate(party.value!.id);
    await getParty();
  }

  Future<void> cancelParty() async {
    final AuthController auth = Get.find<AuthController>();
    print(party.value!.hostId);
    print(auth.me.value!.id);
    if(party.value!.hostId != auth.me.value!.id) return;
    await partyRepository.cancelParty(party.value!.id);
    Get.back();
  }

  Future<void> editParty() async {
    await Get.toNamed(Routes.createParty);
    await getParty();
  }
}