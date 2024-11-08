import 'package:flutter/material.dart';

import '../../../loading_screen.dart';
import '../../../services/api_service.dart';
import '../../widgets/custom_button.dart';
import '../register_page_model.dart';
import './custom_dropdown_field.dart';
import 'custom_text_field.dart';

class RegisterForm extends StatelessWidget {
  final RegisterPageModel model;
  final bool isKeyboardVisible;

  // Add a GlobalKey for the Form widget
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  RegisterForm({
    super.key,
    required this.model,
    required this.isKeyboardVisible,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
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
                        // Wrap the form fields in a Form widget and pass the _formKey
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildFormFields(context),
                              _buildCheckbox(context),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (!isKeyboardVisible) _buildSubmitButton(context),
              ],
            ),
          ),
        ),
        if (model.isLoading) const LoadingScreen(isLoading: true),
      ],
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
          onChanged: (_) =>
              _formKey.currentState?.validate(), // Real-time validation
        ),
        CustomTextField(
          controller: model.textController2,
          focusNode: model.textFieldFocusNode2,
          labelText: 'Telephone Number',
          textCapitalization: TextCapitalization.words,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your phone number';
            }
            if (!RegExp(r'^\d+$').hasMatch(value)) {
              return 'Phone must contain only numbers';
            }
            if (value.length != 10 || !RegExp(r'^\d+$').hasMatch(value)) {
              return 'Phone number must be 10 digits';
            }
            return null;
          },
          onChanged: (_) => _formKey.currentState?.validate(),
        ),
        CustomTextField(
          controller: model.textController3,
          focusNode: model.textFieldFocusNode3,
          labelText: 'Email Address',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            if (!value.contains('@')) {
              return 'Enter a valid email';
            }
            return null;
          },
          onChanged: (_) => _formKey.currentState?.validate(),
        ),
        CustomTextField(
          controller: model.textController4,
          focusNode: model.textFieldFocusNode4,
          labelText: 'Password',
          isPassword: true,
          passwordVisibility: model.passwordVisibility,
          onTogglePassword: () => model.togglePasswordVisibility(),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a password';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
          onChanged: (_) => _formKey.currentState?.validate(),
        ),
        _buildGenderDropdown(context),
        _buildZodiacDropdown(context),
      ],
    );
  }

  Widget _buildGenderDropdown(BuildContext context) {
    return CustomDropdownField<String>(
        labelText: 'Gender',
        value: model.selectedGender,
        items: ['Male', 'Female', 'Other']
            .map((gender) => DropdownMenuItem(
                  value: gender,
                  child: Text(gender),
                ))
            .toList(),
        onChanged: (value) => model.setGender(value),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select a gender';
          }
          return null;
        });
  }

  Widget _buildZodiacDropdown(BuildContext context) {
    return CustomDropdownField<Zodiac>(
        labelText: 'Zodiac Sign',
        value: model.selectedZodiac,
        items: model.zodiacs
            .map((zodiac) => DropdownMenuItem(
                  value: zodiac,
                  child: Text(zodiac.name),
                ))
            .toList(),
        onChanged: (value) => model.setZodiac(value),
        validator: (value) {
          if (value == null) {
            return 'Please select a zodiac';
          }
          return null;
        });
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
          if (!_formKey.currentState!.validate()) {
            return; // Stop if form fields are not valid
          }

          final displayName = model.textController1?.text;
          final telephoneNumber = model.textController2?.text;
          final email = model.textController3?.text;
          final password = model.textController4?.text;
          final gender = model.selectedGender;
          final zodiacId = model.selectedZodiac?.id;

          if (displayName!.isEmpty ||
              telephoneNumber!.isEmpty ||
              email!.isEmpty ||
              password!.isEmpty ||
              gender == null ||
              zodiacId == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please fill in all the fields.')),
            );
            return;
          }

          model.setLoading(true);

          final response = await apiService.register(
            email: email,
            password: password,
            fullName: displayName,
            telephoneNumber: telephoneNumber,
            gender: gender,
            zodiacId: zodiacId,
          );

          model.setLoading(false);

          if (response['success'] == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                      'Registration successful! Please confirm the link to access your account!')),
            );
            Navigator.pushReplacementNamed(context, '/');
          } else {
            final errorMessage =
                response['message'] ?? 'Registration failed. Please try again.';
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
