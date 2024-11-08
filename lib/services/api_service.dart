import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../pages/ProfilePage/user_model.dart';
import './storage_service.dart';

class ApiService {
  static final Logger logger = Logger();
  static const String baseUrl =
      'https://starmate-g8dkcraeardagdfb.canadacentral-01.azurewebsites.net/api/authentication';
  static const String baseUserUrl =
      'https://starmate-g8dkcraeardagdfb.canadacentral-01.azurewebsites.net/api/users';
  static const String baseFriendUserUrl =
      'https://starmate-g8dkcraeardagdfb.canadacentral-01.azurewebsites.net/api/Friend/user/';

  static const String baseFriendUrl =
      'https://starmate-g8dkcraeardagdfb.canadacentral-01.azurewebsites.net/api/Friend';

  // Hàm đăng ký tài khoản
  Future<Map<String, dynamic>?> register({
    required String email,
    required String password,
    required String fullName,
    required String telephoneNumber,
  }) async {
    final url = Uri.parse('$baseUrl/register');
    final headers = {
      'Content-Type': 'application/json',
      'accept': '*/*',
    };
    final body = jsonEncode({
      'email': email,
      'password': password,
      'fullName': fullName,
      'telephoneNumber': telephoneNumber,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return responseData; // Success response
      } else {
        // Print the error message from the API response
        print('Error: ${response.statusCode} - ${responseData['message']}');
        return responseData; // Return the responseData for further handling
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // Hàm đăng nhập tài khoản
  Future<Map<String, dynamic>?> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/login');
    final headers = {
      'Content-Type': 'application/json',
      'accept': '*/*',
    };
    final body = jsonEncode({
      'email': email,
      'password': password,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Lưu userId (hint) vào storage nếu login thành công
        if (responseData['hint'] != null) {
          await StorageService.saveUserId(responseData['hint']);
        }
        return responseData;
      } else {
        print('Error: ${response.statusCode} - ${responseData['message']}');
        return responseData;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // Forgot Password API
  Future<Map<String, dynamic>?> forgotPassword(String email) async {
    final url = Uri.parse('$baseUrl/forgot-password?email=$email');
    final headers = {
      'accept': '*/*',
    };

    try {
      final response = await http.post(url, headers: headers);

      // Parse the response body regardless of the status code
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return responseData; // Success response
      } else {
        // Print the error message from the API response
        print('Error: ${response.statusCode} - ${responseData['message']}');
        return responseData; // Return the responseData for further handling
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  static Future<dynamic> verifyOtp({
    required String email,
    required String codeOTP,
  }) async {
    final url = Uri.parse('$baseUrl/verify-otp');
    final headers = {
      'Content-Type': 'application/json',
      'accept': '*/*',
    };
    final body = jsonEncode({
      'email': email,
      'codeOTP': codeOTP,
    });
    try {
      final response = await http.post(url, headers: headers, body: body);
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return responseData; // Success response
      } else {
        print('Error: ${response.statusCode} - ${responseData['message']}');
        return responseData; // Return the responseData for further handling
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> resetPassword({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final url = Uri.parse('$baseUrl/reset-password');
    final headers = {
      'Content-Type': 'application/json',
      'accept': '*/*',
    };
    final body = jsonEncode({
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      // Log the response body for debugging
      print('Response Body: ${response.body}');

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return responseData; // Success response
      } else {
        print('Error: ${response.statusCode} - ${responseData['message']}');
        return responseData; // Return the responseData for further handling
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<User?> getUserInfo() async {
    // Lấy userId từ storage
    final userId = await StorageService.getUserId();
    if (userId == null) {
      print('Error: No user ID found in storage');
      return null;
    }

    final url = Uri.parse('$baseUserUrl/$userId');
    final headers = {
      'accept': '*/*',
    };

    try {
      final response = await http.get(url, headers: headers);
      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return User.fromJson(responseData);
      } else {
        print('Error: ${response.statusCode} - ${responseData['message']}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> getFriends() async {
    final userId = await StorageService.getUserId();
    if (userId == null) return null;

    final url = Uri.parse('$baseFriendUserUrl$userId');
    final headers = {
      'accept': 'text/plain',
    };

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data['data']);
      } else {
        print('Failed to fetch friends: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching friends: $e');
      return null;
    }
  }

  //update user profile
  Future<Map<String, dynamic>?> updateUser({
    required String fullName,
    required String telephoneNumber,
    required int zodiacId,
    required String description,
    required String email,
  }) async {
    try {
      // 1. Debug userId
      final userId = await StorageService.getUserId();
      print('1. UserId from storage: $userId');

      if (userId == null) {
        throw Exception('Không tìm thấy userId trong storage');
      }

      // 2. Debug URL
      final url = Uri.parse('$baseUserUrl/$userId');
      print('2. Request URL: $url');

      // 3. Debug Headers
      final headers = {
        'Content-Type': 'application/json',
        'accept': '*/*',
      };
      print('3. Request headers: $headers');

      // 4. Debug Request Body
      final requestBody = {
        'fullName': fullName,
        'telephoneNumber': telephoneNumber,
        'zodiacId': zodiacId,
        'description': description, // Đảm bảo đúng tên field
        'email': email,
      };
      print('4. Request body: ${jsonEncode(requestBody)}');

      // 5. Thực hiện request và debug response
      print('5. Đang gửi request...');
      final response = await http.put(
        url,
        headers: headers,
        body: jsonEncode(requestBody),
      );

      // 6. Debug Response
      print('6. Response status code: ${response.statusCode}');
      print('6. Response body: ${response.body}');

      // 7. Xử lý response
      if (response.statusCode == 200) {
        print('7. Update successfully');
        return jsonDecode(response.body);
      } else {
        print('7. Error from server: ${response.statusCode}');
        print('7. Error body: ${response.body}');
        throw Exception(
            'Error from server: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('8. Error: $e');
      rethrow;
    }
  }

  // Add this function in ApiService
  static Future<void> sendFriendRequest(int friendId) async {
    final userId =
        await StorageService.getUserId(); // Retrieve the stored user ID
    if (userId == null) throw Exception("User ID not found in storage.");

    const url = baseFriendUrl;
    final requestBody = jsonEncode({
      "id": 0, // Keep 0 as specified
      "userId": userId,
      "friendId": friendId
    });

    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: requestBody,
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['success'] == true) {
        ApiService.logger.i('Friend request sent successfully.');
      } else {
        ApiService.logger
            .w('Failed to send friend request: ${responseData['message']}');
      }
    } else {
      ApiService.logger.e(
          'Error sending friend request: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to send friend request.');
    }
  }

  static Future<List<dynamic>> getFriendRequests(int userId) async {
    final url = '$baseFriendUrl/FriendRequestIncome/$userId';

    final response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "accept": "text/plain",
    });

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['success'] == true) {
        logger.i('Friend requests fetched successfully.');
        return responseData['data'] ?? [];
      } else {
        logger.w('Failed to fetch friend requests: ${responseData['message']}');
      }
    } else {
      logger.e('Error fetching friend requests: ${response.statusCode}');
    }
    return [];
  }

  static Future<Map<String, dynamic>> acceptFriendRequest({
    required int userId,
    required int friendId,
  }) async {
    final url = Uri.parse('$baseFriendUrl/accept').replace(
      queryParameters: {
        'userId': userId.toString(),
        'friendId': friendId.toString(),
      },
    );

    try {
      final response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
          "accept": "*/*",
        },
      );

      final responseData = json.decode(response.body);
      logger.i('Accept friend request response: $responseData');

      return {
        'success':
            response.statusCode == 200 && responseData['success'] == true,
        'message': responseData['message'] ?? 'Unknown error occurred',
        'data': responseData['data'],
      };
    } catch (e) {
      logger.e('Error accepting friend request: $e');
      return {
        'success': false,
        'message': 'Failed to accept friend request',
        'error': e.toString(),
      };
    }
  }

  static Future<Map<String, dynamic>> declineFriendRequest({
    required int userId,
    required int friendId,
  }) async {
    final url = Uri.parse('$baseFriendUrl/decline').replace(
      queryParameters: {
        'userId': userId.toString(),
        'friendId': friendId.toString(),
      },
    );

    try {
      final response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
          "accept": "*/*",
        },
      );

      final responseData = json.decode(response.body);
      logger.i('Decline friend request response: $responseData');

      return {
        'success':
            response.statusCode == 200 && responseData['success'] == true,
        'message': responseData['message'] ?? 'Unknown error occurred',
        'data': responseData['data'],
      };
    } catch (e) {
      logger.e('Error declining friend request: $e');
      return {
        'success': false,
        'message': 'Failed to decline friend request',
        'error': e.toString(),
      };
    }
  }

  static Future<List<dynamic>> getSentFriendRequests(int userId) async {
    final url = '$baseFriendUrl/FriendRequest/$userId';

    final response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "accept": "text/plain",
    });

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['success'] == true) {
        logger.i('Sent friend requests fetched successfully.');
        return responseData['data'] ?? [];
      } else {
        logger.w(
            'Failed to fetch sent friend requests: ${responseData['message']}');
      }
    } else {
      logger.e('Error fetching sent friend requests: ${response.statusCode}');
    }
    return [];
  }
}
