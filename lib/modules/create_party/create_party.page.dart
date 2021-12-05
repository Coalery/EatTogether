import 'package:eat_together/common/constant.dart';
import 'package:eat_together/modules/create_party/create_party.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatePartyPage extends GetView<CreatePartyController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: controller.pageController,
          children: [
            _TextInputPage()
          ],
        )
      ),
    );
  }
}

class _TextInputPage extends GetView<CreatePartyController> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          Column(
            children: [
              Text('같이 먹을래의 제목'),
              TextFormField(
                controller: controller.titleController,
                validator: (val) {
                  if(val == null || val.isEmpty) return '제목을 입력해주세요.'; 
                  return null;
                },
              ),
              Text('같이 먹을래의 설명 (선택)'),
              TextFormField(
                controller: controller.descsriptionController,
              ),
              Text('시킬 가게'),
              Text('누구나 가게를 특정할 수 있도록 써주세요! ex) OO동 OO치킨, OO마트 앞 OO버거'),
              TextFormField(
                controller: controller.restuarantController,
                validator: (val) {
                  if(val == null || val.isEmpty) return '시킬 가게를 입력해주세요.';
                  return null;
                },
              ),
              Text('목표 금액'),
              TextFormField(
                controller: controller.goalPriceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  suffix: Text('원')
                ),
                validator: (val) {
                  if(val == null || val.isEmpty) return '목표 금액을 입력해주세요.';
                  
                  int? parsedVal = int.tryParse(val);
                  if(parsedVal == null) return '정수로 입력해주세요.';
                  if(parsedVal < 0) return '양수를 입력해주세요.';

                  return null;
                },
              )
            ],
          ),
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Constant.mainColor)
            ),
            onPressed: controller.onClickNext,
            child: Text(
              '다음',
              style: TextStyle(color: Colors.white),
            )
          )
        ],
      ),
    );
  }
}