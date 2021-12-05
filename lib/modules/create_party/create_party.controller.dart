import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatePartyController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController titleController = TextEditingController();
  TextEditingController descsriptionController = TextEditingController();
  TextEditingController restuarantController = TextEditingController();
  TextEditingController goalPriceController = TextEditingController();

  PageController pageController = PageController();

  @override
  void onClose() {
    titleController.dispose();
    descsriptionController.dispose();
    restuarantController.dispose();
    goalPriceController.dispose();
    pageController.dispose();
    super.onClose();
  }

  void onClickNext() {
    if(formKey.currentState!.validate()) {
      pageController.animateToPage(
        1,
        duration: Duration(milliseconds: 200),
        curve: Curves.fastOutSlowIn
      );
    }
  }
}