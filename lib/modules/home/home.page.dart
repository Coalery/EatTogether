import 'package:eat_together/common/constant.dart';
import 'package:eat_together/data/model/party.model.dart';
import 'package:eat_together/modules/home/home.controller.dart';
import 'package:eat_together/modules/home/party_item.dart';
import 'package:eat_together/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends GetView<HomeController> {
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
          () => controller.isRefreshing.value
            ? Loading(title: '주변 500m 안에 있는 "같이 먹을래?"를 찾고 있습니다!')
            : _DataListView()
        )
      ),
    );
  }
}

class _DataListView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: controller.refreshController,
      onRefresh: controller.getPartyNear500m,
      child: ListView.separated(
        itemCount: controller.data.length,
        itemBuilder: (_, idx) {
          Party curParty = controller.data[idx];
          return PartyItem(party: curParty);
        },
        separatorBuilder: (_, idx) => Divider(height: 1),
      ),
    );
  }
}