import 'package:flutter/material.dart';

import '../../../services/api_service.dart';

class ResetPassModel {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Future<void> resetPassword(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    // Validate the password match
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match.')),
      );
      return;
    }

    ApiService apiService = ApiService();
    final response = await apiService.resetPassword(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );

    if (response != null && response['success']) {
      // Handle success (e.g., show a success message and navigate)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password reset successful!')),
      );
    } else {
      // Handle failure (e.g., show error message)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response?['message'] ?? 'Error occurred')),
      );
    }
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}
