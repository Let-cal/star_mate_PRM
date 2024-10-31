import 'package:flutter/material.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';
import '../reset_pass_model.dart';

class ResetForm extends StatefulWidget {
  final String email; // Accept email in the constructor

  const ResetForm({Key? key, required this.email}) : super(key: key); // Use required to enforce the argument

  @override
  _ResetFormState createState() => _ResetFormState();
}

class _ResetFormState extends State<ResetForm> {
  late ResetPassModel _model;

  @override
  void initState() {
    super.initState();
    _model = ResetPassModel();
    _model.emailController.text = widget.email; // Set the email in the controller
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Reset Password', style: Theme.of(context).textTheme.bodyLarge),
          SizedBox(height: 20),
          CustomTextField(
            controller: _model.emailController,
            labelText: 'Email',
            textCapitalization: TextCapitalization.none,
          ),
          CustomTextField(
            controller: _model.passwordController,
            labelText: 'New Password',
            isPassword: true,
          ),
          CustomTextField(
            controller: _model.confirmPasswordController,
            labelText: 'Confirm Password',
            isPassword: true,
          ),
          SizedBox(height: 30),
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
