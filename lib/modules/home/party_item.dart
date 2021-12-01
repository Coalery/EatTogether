import 'package:eat_together/common/util.dart';
import 'package:eat_together/data/model/party.model.dart';
import 'package:eat_together/data/model/user.model.dart';
import 'package:eat_together/routes/app_routes.dart';
import 'package:eat_together/widgets/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PartyItem extends StatelessWidget {
  final Party party;

  PartyItem({required this.party});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
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
                SizedBox(height: 12),
                _HostInfo(host: party.host)
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
            ),
          ],
        ),
      ),
      onTap: () => Get.toNamed(Routes.party, arguments: party.id),
    );
  }
}

class _HostInfo extends StatelessWidget {
  final User host;

  _HostInfo({
    required this.host
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileImage(profileUrl: host.profileUrl),
        SizedBox(width: 8.0),
        Text(host.name)
      ],
    );
  }
}