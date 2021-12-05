import 'package:eat_together/common/constant.dart';
import 'package:eat_together/modules/create_party/create_party.controller.dart';
import 'package:eat_together/modules/create_party/meet_location_selector.dart';
import 'package:eat_together/modules/create_party/party_info_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatePartyPage extends GetView<CreatePartyController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Constant.mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16.0),
              bottomRight: Radius.circular(16.0)
            )
          ),
          centerTitle: true,
          title: Image.asset('assets/logo_transparent.png', width: 64)
        ),
        body: PageView(
          controller: controller.pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            PartyInfoInput(),
            MeetLocationSelector()
          ],
        )
      ),
    );
  }
}