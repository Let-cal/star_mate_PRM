// forgot_page_model.dart
import 'package:flutter/material.dart';

class ForgotPageModel {
  FocusNode? emailFocusNode;
  TextEditingController? emailController;

  void initControllers() {
    emailController = TextEditingController();
    emailFocusNode = FocusNode();
  }

  void dispose() {
    emailFocusNode?.dispose();
    emailController?.dispose();
  }
}
