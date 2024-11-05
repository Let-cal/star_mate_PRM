import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'content_home.dart';
import 'header_home.dart';
import 'featured_section.dart';
import './filter_provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context);

    return Column(
      children: [
        HeaderHome(
          onFiltersUpdated: (zodiacIds, gender) {
            filterProvider.updateFilters(zodiacIds, gender);
          },
        ),
        const FeaturedSection(),
        if (filterProvider.selectedZodiacIds != null &&
            filterProvider.selectedGender != null)
          Expanded(
            child: CustomCardWidget(
              zodiacIds: filterProvider.selectedZodiacIds!,
              gender: filterProvider.selectedGender!,
            ),
          ),
      ],
    );
  }
}
