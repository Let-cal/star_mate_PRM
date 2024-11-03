// lib/pages/FriendPage/friend_page.dart
import 'package:flutter/material.dart';

import '../FriendPage/header_friend.dart';
import 'content_friend.dart';

class FriendPage extends StatelessWidget {
  const FriendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        HeaderFriend(),
        Expanded(
          child: CustomCardWidget(),
        ),
      ],
    );
  }
}
