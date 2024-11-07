import 'package:flutter/material.dart';
import '../../../services/api_service.dart';
import '../../../services/storage_service.dart';

class FriendRequestProvider with ChangeNotifier {
  List<dynamic> _receivedRequests = [];
  List<dynamic> _sentRequests = [];

  int get totalFriendRequests => _receivedRequests.length + _sentRequests.length;

  Future<void> fetchFriendRequests() async {
    final userId = await StorageService.getUserId();
    if (userId != null) {
      try {
        final received = await ApiService.getFriendRequests(userId);
        final sent = await ApiService.getSentFriendRequests(userId);
        _receivedRequests = received;
        _sentRequests = sent;
        notifyListeners(); // Notify listeners so UI updates
      } catch (e) {
        print("Error fetching friend requests: $e");
      }
    }
  }

  List<dynamic> get receivedRequests => _receivedRequests;
  List<dynamic> get sentRequests => _sentRequests;
}