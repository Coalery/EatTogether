import 'package:eat_together/data/model/party.model.dart';
import 'package:flutter/material.dart';
import 'package:eat_together/modules/party/party.controller.dart';
import 'package:get/get.dart';

class PartyPageButtonPanel extends GetView<PartyController> {
  @override
  Widget build(BuildContext context) {
    final Party party = controller.party.value!;

    return Container(height: 5);
  }
}