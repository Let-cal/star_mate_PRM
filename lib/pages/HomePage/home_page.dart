import 'package:flutter/material.dart';
import 'header_home.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          HeaderHome(),
          Expanded(
            child: Center(
              child: Text('Content goes here'), // Nội dung của trang Home
            ),
          ),
        ],
      ),
    );
  }
}
