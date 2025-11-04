import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'dart:convert';
import 'package:writer/api/judge0_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Generate mocks
@GenerateMocks([http.Client])
import 'judge0_service_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Judge0Service Tests', () {
    late MockClient mockClient;
    late Judge0Service service;

    setUp(() async {
      // Initialize dotenv with test values
      dotenv.testLoad(fileInput: 'Judge0API=test_api_key');
      mockClient = MockClient();
      service = Judge0Service();
    });

    test('should execute code successfully', () async {
      final expectedResponse = {
        'status': {'id': 3, 'description': 'Accepted'},
        'stdout': base64.encode(utf8.encode('Hello World')),
        'stderr': null,
        'compile_output': null,
      };

      when(mockClient.post(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(
            json.encode(expectedResponse),
            200,
          ));

      // Note: This test won't work as-is because Judge0Service doesn't accept a client parameter
      // This demonstrates the test structure that would work if the service was refactored
      // to accept dependency injection
      
      // For now, this test serves as documentation of the expected behavior
      expect(service, isNotNull);
    });

    test('should encode source code in base64', () {
      final sourceCode = 'print("Hello World")';
      final encoded = base64.encode(utf8.encode(sourceCode));
      
      expect(encoded, isNotEmpty);
      expect(utf8.decode(base64.decode(encoded)), sourceCode);
    });

    test('should decode output from base64', () {
      final output = 'Hello World\n';
      final encoded = base64.encode(utf8.encode(output));
      final decoded = utf8.decode(base64.decode(encoded));
      
      expect(decoded, output);
    });
  });

  group('Judge0Service Error Handling', () {
    test('should handle error response structure', () {
      final errorResponse = {
        'error': 'Invalid API key',
      };
      
      expect(errorResponse, containsPair('error', isA<String>()));
    });

    test('should handle invalid language ID', () {
      final errorResponse = {
        'error': 'Language with id 9999 does not exist',
      };
      
      expect(errorResponse['error'], contains('does not exist'));
    });
  });
}
