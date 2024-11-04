import 'package:flutter/material.dart';
import 'content_home.dart';
import 'header_home.dart';
import 'featured_section.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<int>? selectedZodiacIds;
  String? selectedGender;

  void updateFilters(List<int> zodiacIds, String gender) {
    setState(() {
      selectedZodiacIds = zodiacIds;
      selectedGender = gender;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderHome(
          onFiltersUpdated: updateFilters,
        ),
        const FeaturedSection(),
        if (selectedZodiacIds != null && selectedGender != null)
          Expanded(
            child: CustomCardWidget(
              zodiacIds: selectedZodiacIds!,
              gender: selectedGender!,
            ),
          ),
      ],
    );
  }
}
