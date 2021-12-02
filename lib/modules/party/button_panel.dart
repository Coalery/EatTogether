import 'package:eat_together/common/constant.dart';
import 'package:eat_together/data/model/party.model.dart';
import 'package:eat_together/data/model/user.model.dart';
import 'package:eat_together/global/auth.controller.dart';
import 'package:flutter/material.dart';
import 'package:eat_together/modules/party/party.controller.dart';
import 'package:get/get.dart';

class PartyPageButtonPanel extends GetView<PartyController> {
  @override
  Widget build(BuildContext context) {
    final AuthController auth = Get.find<AuthController>();
    final User me = auth.me.value!;
    final Party party = controller.party.value!;

    Widget result;

    if(party.isHost(me)) {
      result = _ButtonForHost();
    } else if(party.isParticipated(me)) {
      result = _ButtonForParticipated();
    } else {
      result = _ButtonForNotParticipated(); 
    }
    result = _ButtonForNotParticipated(); 

    return SizedBox(
      width: Get.width - 16.0 - 16.0 - 16.0 - 50.0,
      height: 40,
      child: result,
    );
  }
}

class _ButtonForNotParticipated extends GetView<PartyController> {
  @override
  Widget build(BuildContext context) {
    final Party party = controller.party.value!;

    return TextButton(
      child: Text(
        party.isParticipating ? '참가하기' : '모집 완료',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold
        ),
      ),
      onPressed: () => controller.participate(context),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Constant.mainColor.withOpacity(
            party.isParticipating ? 1.0 : 0.4
          )
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0)
          )
        )
      ),
    );
  }
}

class _ButtonForParticipated extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(''),
      onPressed: () {},
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0)
          )
        )
      ),
    );
  }
}

class _ButtonForHost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(''),
      onPressed: () {},
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0)
          )
        )
      ),
    );
  }
}