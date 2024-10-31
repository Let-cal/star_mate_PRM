import 'package:flutter/material.dart';

class LoginPageModel extends ChangeNotifier {
  final emailAddressTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final emailAddressFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  bool passwordVisibility = false;

  String? emailAddressTextControllerValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    return null;
  }

  String? passwordTextControllerValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  @override
  void dispose() {
    emailAddressTextController.dispose();
    passwordTextController.dispose();
    emailAddressFocusNode.dispose();
    passwordFocusNode.dispose();
  }
}
