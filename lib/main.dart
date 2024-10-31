import 'package:flutter/material.dart';
import 'theme/theme.dart';
import 'theme/util.dart';
import './pages/HomePage/home_page.dart';
import './pages/LoginPage/login_page.dart';
import './pages/RegisterPage/register_page_widget.dart';
import './pages/ForgotPage/forgot_page.dart';

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
      title: 'Star Mate',
      theme: materialTheme.light(),
      darkTheme: materialTheme.dark(),
      routes: {
        '/': (context) => const LoginPageWidget(),
        '/register': (context) => const RegisterPageWidget(),
        '/forgot_pass': (context) => const ForgotPageWidget(),
        '/home': (context) => const Home(),
      },
    );
  }
}
