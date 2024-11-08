import 'package:flutter/material.dart';

import '../../../services/api_service.dart'; // Import your API service

class SentOtpModel {
  final TextEditingController emailController = TextEditingController();
  final List<TextEditingController> otpControllers =
      List.generate(6, (_) => TextEditingController());

  void dispose() {
    emailController.dispose();
    for (var controller in otpControllers) {
      controller.dispose();
    }
  }

  void _navigateToResetPage(BuildContext context, String email) {
    Navigator.of(context).pushNamed(
      '/reset_pass',
      arguments: email, // Pass the email as an argument
    );
  }

  Future<void> resetPassword(BuildContext context) async {
    final otpCode = otpControllers.map((controller) => controller.text).join();
    final email = emailController.text;

    if (otpCode.length == 6) {
      final response =
          await ApiService.verifyOtp(email: email, codeOTP: otpCode);

      if (response != null && response is Map) {
        if (response['success'] == true) {
          // Check if context is still valid (mounted) before showing the SnackBar or navigating
          if (!context.mounted) return; // Ensure context is mounted

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('OTP verified successfully!')),
          );

          // Delayed navigation to avoid issues after async operations
          Future.microtask(() {
            if (context.mounted) {
              _navigateToResetPage(context, email);
            }
          });
        } else {
          if (!context.mounted) return; // Ensure context is mounted

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${response['message']}')),
          );
        }
      } else {
        if (!context.mounted) return; // Ensure context is mounted

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to verify OTP.')),
        );
      }
    } else {
      if (!context.mounted) return; // Ensure context is mounted

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid 6-digit OTP.')),
      );
    }
  }
}
