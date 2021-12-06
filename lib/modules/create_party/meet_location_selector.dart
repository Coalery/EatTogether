import 'package:eat_together/modules/create_party/create_party.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';

class MeetLocationSelector extends GetView<CreatePartyController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
      children: <Widget>[
        NaverMap(
          onMapTap: controller.createMarker,
          markers: [
            if(controller.marker.value != null) ... {
              controller.marker.value!
            }
          ],
          initLocationTrackingMode: LocationTrackingMode.Follow,
        )
      ],
    ));
  }
}