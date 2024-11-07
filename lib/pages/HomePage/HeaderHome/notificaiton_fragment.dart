import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../services/api_service.dart';
import '../../../services/storage_service.dart';
import './friend_request_provider.dart';

class NotificationFragment extends StatefulWidget {
  const NotificationFragment({super.key});

  @override
  _NotificationFragmentState createState() => _NotificationFragmentState();
}

class _NotificationFragmentState extends State<NotificationFragment>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late FriendRequestProvider _friendRequestProvider;
  // ignore: unused_field
  List<dynamic> _receivedRequests = [];
  // ignore: unused_field
  List<dynamic> _sentRequests = [];
  final Map<String, IconData> zodiacIcons = {
    'Aries': Icons.star,
    'Taurus': FontAwesomeIcons.bullhorn,
    'Gemini': FontAwesomeIcons.handHoldingHeart,
    'Cancer': Icons.emoji_nature,
    'Leo': Icons.directions_run,
    'Virgo': Icons.star_border,
    'Libra': FontAwesomeIcons.scaleBalanced,
    'Scorpio': Icons.security,
    'Sagittarius': FontAwesomeIcons.horse,
    'Capricorn': FontAwesomeIcons.mountain,
    'Aquarius': Icons.water_drop,
    'Pisces': FontAwesomeIcons.fish
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<void> _fetchFriendRequests() async {
    final userId = await StorageService.getUserId();
    if (userId != null) {
      final received = await ApiService.getFriendRequests(userId);
      final sent = await ApiService.getSentFriendRequests(userId);
      setState(() {
        _receivedRequests = received;
        _sentRequests = sent;
      });
    }
  }

  void _showBottomSheetNotification(
      BuildContext context, String message, IconData icon, Color color) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: color,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Access the FriendRequestProvider
    _friendRequestProvider = Provider.of<FriendRequestProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Requests Received"),
            Tab(text: "Requests Sent"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildRequestList(_friendRequestProvider.receivedRequests,
              isReceived: true),
          _buildRequestList(_friendRequestProvider.sentRequests,
              isReceived: false),
        ],
      ),
    );
  }

  Widget _buildRequestList(List<dynamic> requests, {required bool isReceived}) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ListView.separated(
      itemCount: requests.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final request = requests[index];
        final friendName = request['friendName'];
        final zodiacName = request['zodiacName'];
        final zodiacIcon = zodiacIcons[zodiacName];
        return ListTile(
          leading: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                friendName[0].toUpperCase(),
                style: textTheme.headlineMedium?.copyWith(
                  color: colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          title: Text(friendName),
          subtitle: Row(
            children: [
              Icon(zodiacIcon,
                  color: colorScheme.primary, size: 18), // Zodiac icon
              const SizedBox(width: 8),
              Text(
                zodiacName,
                style: textTheme.bodySmall
                    ?.copyWith(fontSize: 12), // Smaller font for zodiac name
              ),
            ],
          ),
          trailing: isReceived == false
              ? null // No buttons for received requests
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () => _acceptFriendRequest(request),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                      ),
                      child: const Text('Accept'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () => _declineFriendRequest(request),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.error,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                      ),
                      child: const Text('Decline'),
                    ),
                  ],
                ),
        );
      },
    );
  }

  Future<void> _acceptFriendRequest(dynamic request) async {
    final userId = await StorageService.getUserId();
    if (userId != null) {
      try {
        final response = await ApiService.acceptFriendRequest(
          userId: userId,
          friendId: request['friendId'],
        );

        if (response['success']) {
          _showBottomSheetNotification(
            context,
            'Friend request accepted successfully!',
            Icons.check_circle,
            Colors.green,
          );

          await _fetchFriendRequests();
          Provider.of<FriendRequestProvider>(context, listen: false)
              .fetchFriendRequests();
        } else {
          _showBottomSheetNotification(
            context,
            'Failed to accept friend request',
            Icons.error,
            Colors.red,
          );
        }
      } catch (e) {
        _showBottomSheetNotification(
          context,
          'Error accepting friend request',
          Icons.error,
          Colors.red,
        );
      }
    }
  }

  Future<void> _declineFriendRequest(dynamic request) async {
    final userId = await StorageService.getUserId();
    if (userId != null) {
      try {
        final response = await ApiService.declineFriendRequest(
          userId: userId,
          friendId: request['friendId'],
        );

        if (response['success']) {
          _showBottomSheetNotification(
            context,
            'Friend request declined',
            Icons.check_circle,
            Colors.blue,
          );

          await _fetchFriendRequests();
          Provider.of<FriendRequestProvider>(context, listen: false)
              .fetchFriendRequests();
        } else {
          _showBottomSheetNotification(
            context,
            'Failed to decline friend request',
            Icons.error,
            Colors.red,
          );
        }
      } catch (e) {
        _showBottomSheetNotification(
          context,
          'Error declining friend request',
          Icons.error,
          Colors.red,
        );
      }
    }
  }
}
