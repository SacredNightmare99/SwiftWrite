import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Judge0Service {
  final String _baseUrl = 'https://judge0-ce.p.rapidapi.com';
  final String _apiKey = dotenv.env['Judge0API']!;
  final String _apiHost = 'judge0-ce.p.rapidapi.com';

  /// Executes the code and waits for the result in a single API call.
  /// Returns a Map containing the full execution result.
  Future<Map<String, dynamic>> executeCode(String sourceCode, int languageId) async {
    final uri = Uri.parse('$_baseUrl/submissions?base64_encoded=true&wait=true&fields=*');

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'X-RapidAPI-Key': _apiKey,
        'X-RapidAPI-Host': _apiHost,
      },
      body: jsonEncode({
        'source_code': base64.encode(utf8.encode(sourceCode)),
        'language_id': languageId,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception('Failed to execute code: ${errorBody['error'] ?? response.reasonPhrase}');
    }
  }
}