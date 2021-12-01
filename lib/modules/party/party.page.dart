import 'package:eat_together/common/util.dart';
import 'package:eat_together/data/model/participant.model.dart';
import 'package:eat_together/data/model/party.model.dart';
import 'package:eat_together/data/model/user.model.dart';
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

class _PartyDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _PartyCommonInfo(),
        Divider(height: 4, thickness: 4),
        PartyPageButtonPanel(),
        Divider(height: 4, thickness: 4),
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
                  color: Color(0xFF9AD3BC),
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              )
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
        _ParticipantItem(user: party.host, amount: -1),
        ...party.participants.map(
          (participant) => _ParticipantItem(
            user: participant.user,
            amount: participant.amount,
          )
        ).toList()
      ],
    );
  }
}

class _ParticipantItem extends StatelessWidget {
  final User user;
  final int amount;

  _ParticipantItem({
    required this.user,
    required this.amount
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ProfileImage(
        radius: 16.0,
        profileUrl: user.profileUrl,
      ),
      title: Text(
        user.name
      ),
      trailing: amount == -1
        ? Text('호스트')
        : Text(
            toCurrencyString(amount),
            style: TextStyle(
              color: Color(0xFF9AD3BC),
            ),
          )
    );
  }
}