import 'package:eat_together/data/model/party.model.dart';
import 'package:eat_together/modules/home/home.controller.dart';
import 'package:eat_together/modules/home/party_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends GetView<HomeController> {
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
          title: FittedBox(
            fit: BoxFit.fitHeight,
            child: Image.asset('assets/logo_transparent.png', width: 64)
          )
        ),
        body: Obx(
          () => controller.isRefreshing.value ? _Loading() : _DataListView()
        )
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          CircularProgressIndicator(),
          SizedBox(height: 8),
          Text('주변 500m 안에 있는 "같이 먹을래?"를 찾고 있습니다!')
        ],
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