// home.dart

import 'package:flutter/material.dart';
import 'content_home.dart';
import 'header_home.dart';
import 'featured_section.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        HeaderHome(),
        FeaturedSection(),
        Expanded(
          child: CustomCardWidget(),
        ),
      ],
    );
  }
}