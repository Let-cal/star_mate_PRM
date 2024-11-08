// forgot_form.dart
import 'package:flutter/material.dart';

import '../../../services/api_service.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../forgot_page_model.dart';

class ForgotForm extends StatelessWidget {
  final ForgotPageModel model;
  final bool isKeyboardVisible;

  const ForgotForm({
    super.key,
    required this.model,
    required this.isKeyboardVisible,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 670),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context),
                    _buildFormFields(context),
                  ],
                ),
              ),
            ),
            if (!isKeyboardVisible) _buildSubmitButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 32, 0, 8),
          child: Text(
            'Forgot Password?',
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 0, 12),
          child: Text(
            'Enter your email and we\'ll send you instructions to reset your password.',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ],
    );
  }

  Widget _buildFormFields(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: model.emailController,
          focusNode: model.emailFocusNode,
          labelText: 'Email Address',
        ),
      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      child: CustomButton(
        onPressed: () async {
          final email = model.emailController?.text;

          // Check if email is empty
          if (email == null || email.isEmpty) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Please enter your email address.')),
              );
            }
            return;
          }

          // Call the Forgot Password API
          final apiService = ApiService();
          final response = await apiService.forgotPassword(email);
          print(email);
          if (response != null && response['success'] == true) {
            // Ensure context is mounted before showing snackbar
            _showSuccessSnackBar(context);

            // Use Future.delayed to delay the navigation and ensure context is valid
            Future.delayed(const Duration(milliseconds: 200), () {
              if (context.mounted) {
                Navigator.of(context).pushNamed(
                  '/sent_otp',
                  arguments: email, // Pass the email as an argument
                );
              }
            });
          } else {
            _showFailureSnackBar(context, response);
          }
        },
        text: 'Send Reset Instructions',
      ),
    );
  }

  void _showSuccessSnackBar(BuildContext context) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Password reset instructions sent to your email.')),
      );
    }
  }

  void _showFailureSnackBar(BuildContext context, dynamic response) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            response != null
                ? response['message'] ?? 'Failed to send reset instructions.'
                : 'Failed to send reset instructions.',
          ),
        ),
      );
    }
  }
}
