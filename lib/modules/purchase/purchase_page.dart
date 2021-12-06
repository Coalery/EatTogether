import 'package:eat_together/common/constant.dart';
import 'package:eat_together/global/auth.controller.dart';
import 'package:eat_together/modules/purchase/purchase.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:iamport_flutter/iamport_payment.dart';
import 'package:iamport_flutter/model/payment_data.dart';

class PurchasePage extends GetView<PurchaseController> {
  @override
  Widget build(BuildContext context) {
    return IamportPayment(
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
      initialChild: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                child: Text('잠시만 기다려주세요...', style: TextStyle(fontSize: 20.0)),
              ),
            ],
          ),
        ),
      ),
      userCode: dotenv.env['IAMPORT_USERCODE']!,
      data: PaymentData(
        payMethod: 'card',
        name: '포인트 충전',
        merchantUid: controller.merchantUid!,
        amount: controller.amount,
        buyerTel: '01012345678',
        appScheme: 'eat-together',
      ),
      callback: (result) {
        Get.back(result: result);
      },
    );
  }
}