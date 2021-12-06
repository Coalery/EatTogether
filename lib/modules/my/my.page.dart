import 'package:eat_together/common/constant.dart';
import 'package:eat_together/common/util.dart';
import 'package:eat_together/data/model/party.model.dart';
import 'package:eat_together/data/model/user.model.dart';
import 'package:eat_together/modules/my/my.controller.dart';
import 'package:eat_together/widgets/loading.dart';
import 'package:eat_together/widgets/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPage extends GetView<MyPageController> {
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
          () => controller.isLoading.value
            ? Loading(title: '유저 데이터를 열심히 가져오고 있습니다!')
            : _MyPageDetail()
        ),
      ),
    );
  }
}

class _MyPageDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _UserProfile(),
        Divider(height: 1, thickness: 1),
        _ParticipantList()
      ],
    );
  }
}

class _UserProfile extends GetView<MyPageController> {
  @override
  Widget build(BuildContext context) {
    User user = controller.user!;
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ProfileImage(
                profileUrl: user.profileUrl,
                radius: 20.0,
              ),
              SizedBox(width: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    '포인트 : ${user.point}',
                    style: TextStyle(
                      color: Constant.mainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
          TextButton(
            child: Text(
              '포인트 충전',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            ),
            onPressed: controller.chargePoint,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Constant.mainColor),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)
                )
              )
            ),
          )
        ],
      ),
    );
  }
}

class _ParticipantList extends GetView<MyPageController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 14.0, top: 8.0),
          child: Text(
            '참여 이력',
            style: TextStyle(
              color: Colors.grey
            ),
          ),
        ),
        ...controller.participatedParties.map(
          (party) => _ParticipatedListItem(
            party: party,
          )
        ).toList()
      ],
    );
  }
}

class _ParticipatedListItem extends StatelessWidget {
  final Party party;

  _ParticipatedListItem({required this.party});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                party.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),
              ),
              SizedBox(height: 4),
              Text(party.restuarant),
              SizedBox(height: 12)
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                untilTime(party.createdAt),
                style: TextStyle(
                  color: Colors.grey
                ),
              ),
              SizedBox(height: 30.0),
              Text('현재 상태'),
              SizedBox(height: 4.0),
              Container(
                width: 70,
                height: 20,
                decoration: BoxDecoration(
                  color: colorByState(party.state),
                  borderRadius: BorderRadius.circular(20.0)
                ),
                alignment: Alignment.center,
                child: Text(
                  stateNameByState(party.state),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}