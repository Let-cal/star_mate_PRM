import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'content_home.dart';
import 'HeaderHome/header_home.dart';
import 'featured_section.dart';
import './filter_provider.dart';
import './HeaderHome/friend_request_provider.dart';
class Home extends StatefulWidget {
  const Home({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    // Trigger the fetchFriendRequests when Home widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Fetch friend requests right after the widget is built
      Provider.of<FriendRequestProvider>(context, listen: false).fetchFriendRequests();
    });
  }


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
