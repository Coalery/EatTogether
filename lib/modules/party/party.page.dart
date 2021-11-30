import 'package:eat_together/modules/party/party.controller.dart';
import 'package:eat_together/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PartyPage extends GetView<PartyController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF9AD3BC),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16.0),
              bottomRight: Radius.circular(16.0)
            )
          ),
          centerTitle: true,
          title: Image.asset('assets/logo_transparent.png', width: 64)
        ),
        body: Obx(
          () => controller.isLoading
            ? Loading(title: '같이 먹을래? 데이터를 열심히 가져오고 있습니다!')
            : _PartyDetail()
        ),
      ),
    );
  }
}

class _PartyDetail extends GetView<PartyController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(controller.party.value!.title),
    );
  }
}