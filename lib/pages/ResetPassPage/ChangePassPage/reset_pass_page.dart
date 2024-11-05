import 'package:flutter/material.dart';
import './widgets/reset_form.dart';

class ResetPassPage extends StatelessWidget {
  final String email; // Accept email in the constructor

  const ResetPassPage(
      {super.key, required this.email}); // Use required to enforce the argument

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password',
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
      ),
      body: ResetForm(email: email), // Pass the email to the ResetForm
    );
  }
}
