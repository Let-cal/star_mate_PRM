import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class Person {
  String name;
  String gender;
  String zodiac;
  String description;

  Person({
    required this.name,
    required this.gender,
    required this.zodiac,
    required this.description,
  });
}

class ApiService {
  static final logger = Logger();
  static const baseUrl =
      'https://starmate-g8dkcraeardagdfb.canadacentral-01.azurewebsites.net/api';

  static Future<List<Person>> fetchPeople(
      List<int> zodiacIds, String gender) async {
    try {
      // Construct the URL with multiple zodiacIds
      final zodiacParams = zodiacIds.map((id) => 'zodiacIds=$id').join('&');
      final url = '$baseUrl/users/random?$zodiacParams&gender=$gender';

      logger.d('Fetching from URL: $url'); // Debug log

      final response = await http.get(Uri.parse(url));
      logger.d('Response status: ${response.statusCode}');
      logger.d('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        logger.d('Data received: $data');

        List<Person> fetchedPeople = data.map((item) {
          return Person(
            name: item['fullName'],
            gender: item['gender'],
            zodiac: item['nameZodiac'],
            description: item['decription'],
          );
        }).toList();

        logger.d('Fetched people: $fetchedPeople');
        return fetchedPeople;
      } else {
        logger.e('API Error: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to load people: ${response.statusCode}');
      }
    } catch (e) {
      logger.e('Error fetching people: $e');
      rethrow;
    }
  }
}