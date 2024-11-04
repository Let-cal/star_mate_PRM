import 'package:flutter/material.dart';

import '../../loading_screen.dart';
import '../../services/api_service.dart';
import '../FriendPage/header_friend.dart';
import 'content_friend.dart';

class FriendPage extends StatefulWidget {
  const FriendPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FriendPageState createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  late Future<List<Map<String, dynamic>>?> _friendsFuture;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchFriends();
  }

  void _fetchFriends() {
    setState(() {
      _isLoading = true;
    });
    _friendsFuture = ApiService().getFriends().then((friends) {
      // Removed `context` argument
      setState(() {
        _isLoading = false;
      });
      return friends;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            const HeaderFriend(),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>?>(
                future: _friendsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      _isLoading) {
                    return const LoadingScreen(isLoading: true);
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No friends found.'));
                  } else {
                    final friends = snapshot.data!;
                    return CustomCardWidget(friends: friends);
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
