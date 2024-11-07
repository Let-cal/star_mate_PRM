import 'package:flutter/material.dart';

import '../../loading_screen.dart';
import '../../services/api_service.dart';
import '../FriendPage/header_friend.dart';
import 'content_friend.dart';

class FriendPage extends StatefulWidget {
  const FriendPage({super.key});

  @override
  _FriendPageState createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  late Future<List<Map<String, dynamic>>?> _friendsFuture;
  bool _isLoading = false;
  List<Map<String, dynamic>> _allFriends = [];
  List<Map<String, dynamic>> _filteredFriends = [];

  final TextEditingController _searchController = TextEditingController();
  List<String> _selectedZodiacs = [];
  String? _selectedGender;

  @override
  void initState() {
    super.initState();
    _fetchFriends();
    _searchController.addListener(_filterFriends);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _fetchFriends() {
    setState(() {
      _isLoading = true;
    });
    _friendsFuture = ApiService().getFriends().then((friends) {
      setState(() {
        _isLoading = false;
        if (friends != null) {
          // Normalize gender data
          _allFriends = friends.map((friend) {
            return {
              ...friend,
              'friendGender': friend['friendGender'].toString().toLowerCase(),
            };
          }).toList();
          _filteredFriends = _allFriends;
        }
      });
      return friends;
    });
  }

  void _filterFriends() {
    String searchQuery = _searchController.text.toLowerCase();

    setState(() {
      _filteredFriends = _allFriends.where((friend) {
        // Filter by name
        bool matchesName =
            friend['friendName'].toString().toLowerCase().contains(searchQuery);
// Thêm log này vào hàm _filterFriends để kiểm tra
        print('Friend gender: ${friend['friendGender']}');
        print('Selected gender: $_selectedGender');
        // Filter by zodiac
        bool matchesZodiac = _selectedZodiacs.isEmpty ||
            _selectedZodiacs.contains(friend['zodiacName']);

        // Filter by gender - Make sure the case matches
        bool matchesGender = _selectedGender == null ||
            friend['friendGender'].toString().toLowerCase() ==
                _selectedGender?.toLowerCase();

        return matchesName && matchesZodiac && matchesGender;
      }).toList();
    });
  }

  void _applyFilter(List<String> selectedZodiacs, String? selectedGender) {
    setState(() {
      _selectedZodiacs = selectedZodiacs;
      _selectedGender = selectedGender?.toLowerCase(); // Normalize to lowercase
    });
    _filterFriends();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            HeaderFriend(
              searchController: _searchController,
              onFilterSelected: _applyFilter,
            ),
            Expanded(
              child: _isLoading
                  ? const LoadingScreen(isLoading: true)
                  : _filteredFriends.isEmpty
                      ? const Center(child: Text('No friends found.'))
                      : CustomCardWidget(friends: _filteredFriends),
            ),
          ],
        ),
      ],
    );
  }
}
