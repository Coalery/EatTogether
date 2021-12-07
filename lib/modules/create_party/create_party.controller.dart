import 'package:eat_together/data/model/party.model.dart';
import 'package:eat_together/data/repository/party.repository.dart';
import 'package:eat_together/modules/party/party.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';

class CreatePartyController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descsriptionController = TextEditingController();
  final TextEditingController restuarantController = TextEditingController();
  final TextEditingController goalPriceController = TextEditingController();
  final Rxn<Marker> marker = Rxn();
  final PageController pageController = PageController();

  final PartyRepository partyRepository;

  bool isEditMode = false;

  CreatePartyController({
    required this.partyRepository
  });

  @override
  void onInit() {
    super.onInit();
    
    if(Get.isRegistered<PartyController>()) {
      isEditMode = true;
      Party target = Get.find<PartyController>().party.value!;
      titleController.text = target.title;
      descsriptionController.text = target.description ?? '';
      restuarantController.text = target.restuarant;
      goalPriceController.text = target.goalPrice.toString();
      createMarker(LatLng(target.meetLatitude, target.meetLongitude));
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    descsriptionController.dispose();
    restuarantController.dispose();
    goalPriceController.dispose();
    pageController.dispose();
    super.onClose();
  }

  void onClickNext() {
    if(formKey.currentState!.validate()) {
      pageController.animateToPage(
        1,
        duration: Duration(milliseconds: 200),
        curve: Curves.fastOutSlowIn
      );
    }
  }

  void createMarker(LatLng  latLng) {
    marker(Marker(
      markerId: DateTime.now().toIso8601String(),
      position: latLng,
      captionText: '선택한 위치',
      onMarkerTab: (marker, _) async {
        if(marker == null) return;

        bool isSuccess = false;
        if(isEditMode) {
          isSuccess = await editParty();
        } else {
          isSuccess = await createParty();
        }

        if(isSuccess) {
          Get.back();
        } else {
          Get.snackbar(
            '알 수 없는 문제가 발생했습니다.',
            '서버에서 오류가 발생했습니다.'
          );
        }
      }
    ));
  }

  Future<bool> createParty() async {
    String description = descsriptionController.text;

    dynamic response = await partyRepository.create(
      title: titleController.text,
      description: description.isEmpty ? null : description,
      restuarant: restuarantController.text,
      meetLocation: marker.value!.position,
      goalPrice: int.parse(goalPriceController.text)
    );

    return response['code'] == 200;
  }
  
  Future<bool> editParty() async {
    Party party = Get.find<PartyController>().party.value!;
    String description = descsriptionController.text;

    dynamic response = await partyRepository.edit(
      partyId: party.id,
      description: description.isEmpty ? null : description,
      goalPrice: int.parse(goalPriceController.text),
      meetLocation: marker.value!.position
    );

    return response['code'] == 200;
  }
}