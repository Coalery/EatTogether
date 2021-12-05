import 'package:eat_together/common/constant.dart';
import 'package:eat_together/modules/create_party/create_party.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PartyInfoInput extends GetView<CreatePartyController> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _InputUnit(
                  controller: controller.titleController,
                  title: '같이 먹을래의 제목',
                  validator: (val) {
                    if(val == null || val.isEmpty) return '제목을 입력해주세요.'; 
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                _InputUnit(
                  controller: controller.descsriptionController,
                  title: '같이 먹을래의 설명 (선택)',
                  validator: (val) => null
                ),
                SizedBox(height: 16.0),
                _InputUnit(
                  controller: controller.restuarantController,
                  title: '시킬 가게',
                  subTitle: '누구나 가게를 특정할 수 있도록 써주세요!\nex) OO동 OO치킨, OO마트 앞 OO버거',
                  validator: (val) {
                    if(val == null || val.isEmpty) return '시킬 가게를 입력해주세요.';
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                _InputUnit(
                  controller: controller.goalPriceController,
                  inputType: TextInputType.number,
                  title: '목표 금액',
                  validator: (val) {
                    if(val == null || val.isEmpty) return '목표 금액을 입력해주세요.';
                    
                    int? parsedVal = int.tryParse(val);
                    if(parsedVal == null) return '정수로 입력해주세요.';
                    if(parsedVal < 0) return '양수를 입력해주세요.';

                    return null;
                  },
                ),
              ],
            ),
            SizedBox(height: 32),
            SizedBox(
              width: 100,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Constant.mainColor)
                ),
                onPressed: controller.onClickNext,
                child: Text(
                  '다음',
                  style: TextStyle(color: Colors.white),
                )
              ),
            )
          ],
        ),
      )
    );
  }
}

class _InputUnit extends StatelessWidget {
  final String title;
  final String? subTitle;
  final String? Function(String?) validator;
  final TextEditingController controller;
  final TextInputType inputType;

  _InputUnit({
    required this.title,
    this.subTitle,
    required this.validator,
    required this.controller,
    this.inputType = TextInputType.text
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        if(subTitle != null) ... {
          Text(
            subTitle!,
            style: TextStyle(color: Colors.grey),
          )
        },
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: inputType,
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Constant.mainColor)
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black.withOpacity(0.1))
            ),
          ),
          cursorColor: Constant.mainColor,
        )
      ]
    );
  }
}