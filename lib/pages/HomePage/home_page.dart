import 'package:flutter/material.dart';
import 'header_home.dart';
import 'content_home.dart';
import 'footer_home.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          HeaderHome(),
          Expanded(
            child: CustomCardWidget(),
          ),
          Footer(), // Footer sẽ nằm ở dưới cùng
        ],
      ),
    );
  }
}
