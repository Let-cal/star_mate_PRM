import 'package:flutter/material.dart';

class RegisterPageModel {
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;

  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;

  FocusNode? textFieldFocusNode3;
  TextEditingController? textController3;

  FocusNode? textFieldFocusNode4;
  TextEditingController? textController4;

  bool passwordVisibility = false;
  bool? checkboxListTileValue;

  void initControllers() {
    textController1 = TextEditingController();
    textFieldFocusNode1 = FocusNode();

    textController2 = TextEditingController();
    textFieldFocusNode2 = FocusNode();

    textController3 = TextEditingController();
    textFieldFocusNode3 = FocusNode();

    textController4 = TextEditingController();
    textFieldFocusNode4 = FocusNode();

    checkboxListTileValue = true;
  }

  void togglePasswordVisibility() {
    passwordVisibility = !passwordVisibility;
  }

  void setCheckboxValue(bool value) {
    checkboxListTileValue = value;
  }

  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    textFieldFocusNode3?.dispose();
    textController3?.dispose();

    textFieldFocusNode4?.dispose();
    textController4?.dispose();
  }
}
