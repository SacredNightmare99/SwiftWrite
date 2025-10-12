import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Judge0Service {
  final String _baseUrl = 'https://judge0-ce.p.rapidapi.com';
  final String _apiKey = dotenv.env['Judge0API']!;
  final String _apiHost = 'judge0-ce.p.rapidapi.com';

  Future<String> createSubmission(String sourceCode, int languageId) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/submissions'),
      headers: {
        'Content-Type': 'application/json',
        'X-RapidAPI-Key': _apiKey,
        'X-RapidAPI-Host': _apiHost,
      },
      body: jsonEncode({
        'source_code': sourceCode,
        'language_id': languageId,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body)['token'];
    } else {
      throw Exception('Failed to create submission');
    }
  }

  Future<Map<String, dynamic>> getSubmission(String token) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/submissions/$token'),
      headers: {
        'X-RapidAPI-Key': _apiKey,
        'X-RapidAPI-Host': _apiHost,
      },
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result['status']['id'] <= 2) {
        // Status: In Queue or Processing
        await Future.delayed(const Duration(seconds: 2));
        return getSubmission(token);
      }
      return result;
    } else {
      throw Exception('Failed to get submission');
    }
  }
}
