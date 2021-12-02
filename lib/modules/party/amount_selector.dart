import 'package:eat_together/global/auth.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<int?> showAmountSelector({
  required BuildContext context
}) async {
  int? result = await showModalBottomSheet<int>(
    context: context,
    isDismissible: true,
    isScrollControlled: true,
    builder: (context) {
      return _AmountSelector();
    }
  );
  return result;
}

class _AmountSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250 + MediaQuery.of(context).viewInsets.bottom,
      child: Column(
        children: [
          _Title(),
          Divider(thickness: 1, height: 1),
          _Body()

        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Container(
        height: 50.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10)
          ),
          color: Colors.white
        ),
        child: Text(
          '얼마를 내실건가요?',
          style: TextStyle(
            fontSize: 16
          ),
        )
      )
    );
  }
}

class _Body extends StatefulWidget {
  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  final TextEditingController controller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AuthController auth = Get.find<AuthController>();

    return Container(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '보유 포인트 : ${auth.me.value!.point}',
              style: TextStyle(
                fontSize: 16
              ),
            ),
            TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              validator: (data) {
                if(data == null || data.isEmpty) return '낼 포인트를 입력해주세요.';

                int? parsedData = int.tryParse(data);
                if(parsedData == null) return '정수로 입력해주세요.';
                if(parsedData < 0) return '양의 정수로 입력해주세요.';

                return null;
              },
            ),
            SizedBox(height: 4),
            TextButton(
              onPressed: () {
                if(formKey.currentState!.validate()) {
                  Navigator.pop(context, int.parse(controller.text));
                }
              },
              child: Text(
                '완료',
                style: TextStyle(color: Colors.black),
              )
            )
          ],
        ),
      ),
    );
  }
}