import 'package:flutter/material.dart';
import 'sent_OTP_model.dart';
import '../../widgets/custom_button.dart';

class SentOtpWidget extends StatefulWidget {
  final String email;

  const SentOtpWidget({required this.email, super.key});

  @override
  _SentOtpWidgetState createState() => _SentOtpWidgetState();
}

class _SentOtpWidgetState extends State<SentOtpWidget> {
  late SentOtpModel _model;

  @override
  void initState() {
    super.initState();
    _model = SentOtpModel();
    _model.emailController.text = widget.email;
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  void _onOtpChanged(String value, int index) {
    if (value.length == 1 && index < 5) {
      FocusScope.of(context).nextFocus(); // Move to next TextField
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).previousFocus(); // Move to previous TextField
    }

    // Update other TextFields if the input is pasted
    if (value.length > 1) {
      for (int i = 0; i < value.length && i < 6; i++) {
        _model.otpControllers[i].text = value[i];
        if (i < 5) {
          FocusScope.of(context).nextFocus(); // Move to next TextField
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reset Password',
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'OTP sent to ${widget.email}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 40,
                  child: TextField(
                    controller: _model.otpControllers[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onSurface),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                    maxLength: 1,
                    onChanged: (value) => _onOtpChanged(value, index),
                  ),
                );
              }),
            ),
            const SizedBox(height: 30),
            Center(
              child: CustomButton(
                onPressed: () async {
                  await _model
                      .resetPassword(context); // Pass context for SnackBar
                },
                text: 'Submit',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
