import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './main_container.dart';
import './pages/ForgotPage/forgot_page.dart';
import './pages/LoginPage/login_page.dart';
import './pages/ProfilePage/theme_provider.dart';
import './pages/RegisterPage/register_page_widget.dart';
import 'pages/ResetPassPage/ChangePassPage/reset_pass_page.dart';
import 'pages/ResetPassPage/SentOPT/sent_OTP.dart';
import 'theme/theme.dart';
import 'theme/util.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      builder: (context, child) {
        final themeProvider = context.watch<ThemeProvider>();
        final textTheme = createTextTheme(context, 'ABeeZee', 'Abel');
        final materialTheme = MaterialTheme(textTheme);

        return MaterialApp(
          title: 'Your App Name',
          theme: materialTheme.light(),
          darkTheme: materialTheme.dark(),
          themeMode:
              themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          routes: {
            '/': (context) => const LoginPageWidget(),
            '/register': (context) => const RegisterPageWidget(),
            '/forgot_pass': (context) => const ForgotPageWidget(),
            '/home': (context) => const MainContainer(),
            '/friend': (context) => const MainContainer(),
            '/sent_otp': (context) => SentOtpWidget(
                  email: ModalRoute.of(context)?.settings.arguments as String,
                ),
            '/reset_pass': (context) {
              final email =
                  ModalRoute.of(context)?.settings.arguments as String;
              return ResetPassPage(email: email);
            },
          },
        );
      },
    );
  }
}
