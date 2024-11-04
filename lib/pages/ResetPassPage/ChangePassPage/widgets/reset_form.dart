import 'package:flutter/material.dart';

import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';
import '../reset_pass_model.dart';

class ResetForm extends StatefulWidget {
  final String email; // Accept email in the constructor

  const ResetForm(
      {super.key, required this.email}); // Use required to enforce the argument

  @override
  _ResetFormState createState() => _ResetFormState();
}

class _ResetFormState extends State<ResetForm> {
  late ResetPassModel _model;
  bool passwordVisibility = false;
  bool confirmPasswordVisibility = false;

  @override
  void initState() {
    super.initState();
    _model = ResetPassModel();
    _model.emailController.text =
        widget.email; // Set the email in the controller
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      passwordVisibility = !passwordVisibility;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      confirmPasswordVisibility = !confirmPasswordVisibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Please fill in the password that you want to change !!!',
              style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 20),
          CustomTextField(
            controller: _model.emailController,
            labelText: 'Email',
            textCapitalization: TextCapitalization.none,
          ),
          CustomTextField(
            controller: _model.passwordController,
            labelText: 'New Password',
            isPassword: true,
            passwordVisibility: passwordVisibility,
            onTogglePassword: _togglePasswordVisibility,
          ),
          CustomTextField(
            controller: _model.confirmPasswordController,
            labelText: 'Confirm Password',
            isPassword: true,
            passwordVisibility: confirmPasswordVisibility,
            onTogglePassword: _toggleConfirmPasswordVisibility,
          ),
          const SizedBox(height: 30),
          CustomButton(
            onPressed: () async {
              await _model.resetPassword(context);
            },
            text: 'Reset Password',
          ),
        ],
      ),
    );
  }
}
