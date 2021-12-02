import 'package:eat_together/common/constant.dart';
import 'package:eat_together/common/util.dart';
import 'package:eat_together/data/model/participant.model.dart';
import 'package:eat_together/data/model/party.model.dart';
import 'package:eat_together/modules/party/button_panel.dart';
import 'package:eat_together/modules/party/party.controller.dart';
import 'package:eat_together/widgets/loading.dart';
import 'package:eat_together/widgets/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PartyPage extends GetView<PartyController> {
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
        body: Obx(
          () => controller.isLoading
            ? Loading(title: '같이 먹을래? 데이터를 열심히 가져오고 있습니다!')
            : _PartyDetail()
        ),
      ),
    );
  }
}

class _PartyDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _PartyCommonInfo(),
        Divider(height: 1, thickness: 1),
        _ParticipantList()
      ],
    );
  }
}

class _PartyCommonInfo extends GetView<PartyController> {
  @override
  Widget build(BuildContext context) {
    Party party = controller.party.value!;
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: Text(
              '🍗',
              style: TextStyle(fontSize: 40)
            ),
          ),
          SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                party.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 4),
              if(party.description != null) ... {
                SizedBox(
                  width: Get.width - 16.0 - 16.0 - 16.0 - 50.0,
                  child: Text(
                    party.description!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis
                  ),
                ),
                SizedBox(height: 4)
              },
              Text(
                '시킬 곳 : ${party.restuarant}',
                style: TextStyle(
                  color: Colors.amber[800],
                  fontSize: 16
                ),
              ),
              SizedBox(height: 16.0),
              Text('목표금액'),
              Text(
                toCurrencyString(party.goalPrice),
                style: TextStyle(
                  color: Constant.mainColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
              SizedBox(height: 16),
              PartyPageButtonPanel(),
            ],
          )
        ],
      ),
    );
  }
}

class _ParticipantList extends GetView<PartyController> {
  @override
  Widget build(BuildContext context) {
    final Party party = controller.party.value!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 14.0, top: 8.0),
          child: Text(
            '참가자',
            style: TextStyle(
              color: Colors.grey
            ),
          ),
        ),
        _ParticipantItem(participant: party.host, isHost: true),
        ...party.participants.map(
          (participant) => _ParticipantItem(
            participant: participant,
          )
        ).toList()
      ],
    );
  }
}

class _ParticipantItem extends StatelessWidget {
  final Participant participant;
  final bool isHost;

  _ParticipantItem({
    required this.participant,
    this.isHost = false
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ProfileImage(
        radius: 16.0,
        profileUrl: participant.user.profileUrl,
      ),
      title: Text(
        participant.user.name
      ),
      subtitle: Text(
        isHost ? '호스트' : toCurrencyString(participant.amount),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Constant.mainColor,
          fontSize: 14
        ),
      ),
      trailing: participant.isSuccessAgree
        ? Icon(Icons.check, color: Constant.mainColor)
        : null
    );
  }
}