import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import '../pages/ProfilePage/user_model.dart';
import './storage_service.dart';

class ApiService {
  static const String baseUrl =
      'https://starmate-g8dkcraeardagdfb.canadacentral-01.azurewebsites.net/api/authentication';
  static const String baseUserUrl =
      'https://starmate-g8dkcraeardagdfb.canadacentral-01.azurewebsites.net/api/users';
  static const String baseFriendUrl =
      'https://starmate-g8dkcraeardagdfb.canadacentral-01.azurewebsites.net/api/Friend/user/';
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

    final url = Uri.parse('$baseFriendUrl$userId');
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
}
