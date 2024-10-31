import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'https://starmate-g8dkcraeardagdfb.canadacentral-01.azurewebsites.net/api/authentication';

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
}
