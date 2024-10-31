// widgets/register_form.dart
import 'package:flutter/material.dart';

import '../../../services/api_service.dart'; // Import the ApiService
import '../register_page_model.dart';
import 'custom_button.dart';
import 'custom_text_field.dart';

class RegisterForm extends StatelessWidget {
  final RegisterPageModel model;
  final bool isKeyboardVisible;

  const RegisterForm({
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
                    _buildCheckbox(context),
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
            'Join us & find your soulmate',
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 0, 12),
          child: Text(
            'Save delicious recipes and get personalized content.',
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
          controller: model.textController1,
          focusNode: model.textFieldFocusNode1,
          labelText: 'Display Name',
          textCapitalization: TextCapitalization.words,
        ),
        CustomTextField(
          controller: model.textController2,
          focusNode: model.textFieldFocusNode2,
          labelText: 'Telephone Number',
          textCapitalization: TextCapitalization.words,
        ),
        CustomTextField(
          controller: model.textController3,
          focusNode: model.textFieldFocusNode3,
          labelText: 'Email Address',
        ),
        CustomTextField(
          controller: model.textController4,
          focusNode: model.textFieldFocusNode4,
          labelText: 'Password',
          isPassword: true,
          passwordVisibility: model.passwordVisibility,
          onTogglePassword: () => model.togglePasswordVisibility(),
        ),
      ],
    );
  }

  Widget _buildCheckbox(BuildContext context) {
    return CheckboxListTile(
      value: model.checkboxListTileValue ?? true,
      onChanged: (newValue) => model.setCheckboxValue(newValue ?? true),
      title: Text(
        'I would like to receive inspiration emails.',
        style: Theme.of(context).textTheme.labelMedium,
      ),
      activeColor: Theme.of(context).colorScheme.primary,
      checkColor: Theme.of(context).colorScheme.onPrimary,
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      child: CustomButton(
        onPressed: () async {
          final apiService = ApiService();

          // Fetch values from text controllers
          final displayName = model.textController1?.text;
          final telephoneNumber = model.textController2?.text;
          final email = model.textController3?.text;
          final password = model.textController4?.text;

          // Check if any field is empty
          if (displayName!.isEmpty ||
              telephoneNumber!.isEmpty ||
              email!.isEmpty ||
              password!.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please fill in all the fields.')),
            );
            return;
          }

          // Call the API
          final response = await apiService.register(
            email: email,
            password: password,
            fullName: displayName,
            telephoneNumber: telephoneNumber,
          );

          if (response != null && response['success'] == true) {
            // Show success message
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Registration successful!')),
            );

            // Navigate back to the login page
            // ignore: use_build_context_synchronously
            Navigator.pushReplacementNamed(context, '/');
          } else {
            // Handle failure, show error message from API
            final errorMessage = response?['message'] ??
                'Registration failed. Please try again.';
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(errorMessage)),
            );
          }
        },
        text: 'Create Account',
      ),
    );
  }
}
