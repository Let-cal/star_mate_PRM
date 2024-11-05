import 'package:flutter/material.dart';
import '../../../services/api_service.dart';

class ResetPassModel {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void _navigateToLoginPage(BuildContext context) {
    Navigator.of(context).pushNamed('/');
  }

  Future<void> resetPassword(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    // Validate if passwords match
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match.')),
      );
      return;
    }

    ApiService apiService = ApiService();
    final response = await apiService.resetPassword(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );

    if (response != null && response['success'] == true) {
      // Successful response
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset successful!')),
      );
      _navigateToLoginPage(context); // Call the function with ()
    } else if (response != null && response['status'] == 400) {
      // Handle failure and display error message from response
      final errors = response['errors']?['Password'];
      final errorMessage = (errors != null && errors.isNotEmpty)
          ? errors.first
          : 'An unexpected error occurred';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } else {
      // Handle other errors or null responses
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred.')),
      );
    }
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}
