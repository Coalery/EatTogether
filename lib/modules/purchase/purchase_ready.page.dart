import 'package:eat_together/common/constant.dart';
import 'package:eat_together/modules/purchase/purchase.controller.dart';
import 'package:eat_together/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PurchaseReadyPage extends GetView<PurchaseController> {
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
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _PurchaseButton(amount: 1000),
              SizedBox(height: 16.0),
              _PurchaseButton(amount: 5000),
              SizedBox(height: 16.0),
              _PurchaseButton(amount: 10000),
              SizedBox(height: 16.0),
              _PurchaseButton(amount: 25000),
              SizedBox(height: 16.0),
              _PurchaseButton(amount: 50000),
            ],
          ),
        )
      ),
    );
  }
}

class _PurchaseButton extends GetView<PurchaseController> {
  final int amount;

  _PurchaseButton({
    required this.amount
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: TextButton(
        child: Text(
          '$amount 포인트 충전하기',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        ),
        onPressed: () async {
          controller.amount = amount;
          await controller.requestPurchase();
          dynamic result = await Get.toNamed(Routes.purchase);
          Get.back(result: result);
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Constant.mainColor
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0)
            )
          )
        ),
      ),
    );
  }
}