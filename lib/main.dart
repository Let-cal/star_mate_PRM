import 'package:flutter/material.dart';

import './pages/ForgotPage/forgot_page.dart';
import './pages/LoginPage/login_page.dart';
import './pages/RegisterPage/register_page_widget.dart';
import 'pages/ResetPassPage/SentOPT/sent_OTP.dart';
import 'pages/ResetPassPage/ChangePassPage/reset_pass_page.dart';
import 'theme/theme.dart';
import 'theme/util.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = createTextTheme(context, 'ABeeZee', 'Abel');
    final materialTheme = MaterialTheme(textTheme);

    return MaterialApp(
      title: 'Your App Name',
      theme: materialTheme.light(),
      darkTheme: materialTheme.dark(),
      themeMode: ThemeMode.system,
      routes: {
        '/': (context) => const LoginPageWidget(),
        '/register': (context) => const RegisterPageWidget(),
        '/forgot_pass': (context) => const ForgotPageWidget(),
        '/sent_otp': (context) => SentOtpWidget(
              email: ModalRoute.of(context)?.settings.arguments
                  as String, // Retrieve the email from the route arguments
            ),
        '/reset_pass': (context) {
          final email = ModalRoute.of(context)?.settings.arguments as String; // Retrieve email
          return ResetPassPage(email: email); // Pass the email to the ResetPassPage
        },
      },
    );
  }
}
