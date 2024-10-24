import 'package:flutter/material.dart';
import 'theme/theme.dart';
import 'theme/util.dart';
import './pages/HomePage/home_page.dart';

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
        '/': (context) => const Home(),
      },
    );
  }
}
