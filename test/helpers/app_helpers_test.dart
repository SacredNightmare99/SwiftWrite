import 'package:flutter_test/flutter_test.dart';
import 'package:writer/utils/helpers/helpers.dart';

void main() {
  group('AppHelpers.formatDateTime Tests', () {
    test('should format date with correct time and suffix', () {
      final date = DateTime(2024, 11, 1, 14, 30);
      final result = AppHelpers.formatDateTime(date);
      expect(result, '14:30 @1st Nov');
    });

    test('should format date with 2nd suffix', () {
      final date = DateTime(2024, 11, 2, 9, 15);
      final result = AppHelpers.formatDateTime(date);
      expect(result, '09:15 @2nd Nov');
    });

    test('should format date with 3rd suffix', () {
      final date = DateTime(2024, 11, 3, 18, 45);
      final result = AppHelpers.formatDateTime(date);
      expect(result, '18:45 @3rd Nov');
    });

    test('should format date with th suffix for 4-20', () {
      final date = DateTime(2024, 11, 4, 12, 0);
      final result = AppHelpers.formatDateTime(date);
      expect(result, '12:00 @4th Nov');
    });

    test('should format date with th suffix for 11-13', () {
      final date11 = DateTime(2024, 11, 11, 10, 30);
      final date12 = DateTime(2024, 11, 12, 10, 30);
      final date13 = DateTime(2024, 11, 13, 10, 30);
      
      expect(AppHelpers.formatDateTime(date11), '10:30 @11th Nov');
      expect(AppHelpers.formatDateTime(date12), '10:30 @12th Nov');
      expect(AppHelpers.formatDateTime(date13), '10:30 @13th Nov');
    });

    test('should format date with st suffix for 21, 31', () {
      final date21 = DateTime(2024, 11, 21, 8, 0);
      final date31 = DateTime(2024, 1, 31, 23, 59);
      
      expect(AppHelpers.formatDateTime(date21), '08:00 @21st Nov');
      expect(AppHelpers.formatDateTime(date31), '23:59 @31st Jan');
    });

    test('should format date with nd suffix for 22', () {
      final date = DateTime(2024, 11, 22, 16, 20);
      final result = AppHelpers.formatDateTime(date);
      expect(result, '16:20 @22nd Nov');
    });

    test('should format date with rd suffix for 23', () {
      final date = DateTime(2024, 11, 23, 7, 45);
      final result = AppHelpers.formatDateTime(date);
      expect(result, '07:45 @23rd Nov');
    });
  });

  group('AppHelpers.daySuffix Tests', () {
    test('should return correct suffix for 1, 21, 31', () {
      expect(AppHelpers.daySuffix(1), 'st');
      expect(AppHelpers.daySuffix(21), 'st');
      expect(AppHelpers.daySuffix(31), 'st');
    });

    test('should return correct suffix for 2, 22', () {
      expect(AppHelpers.daySuffix(2), 'nd');
      expect(AppHelpers.daySuffix(22), 'nd');
    });

    test('should return correct suffix for 3, 23', () {
      expect(AppHelpers.daySuffix(3), 'rd');
      expect(AppHelpers.daySuffix(23), 'rd');
    });

    test('should return th for 11, 12, 13', () {
      expect(AppHelpers.daySuffix(11), 'th');
      expect(AppHelpers.daySuffix(12), 'th');
      expect(AppHelpers.daySuffix(13), 'th');
    });

    test('should return th for 4-10, 14-20, 24-30', () {
      for (int i = 4; i <= 10; i++) {
        expect(AppHelpers.daySuffix(i), 'th');
      }
      for (int i = 14; i <= 20; i++) {
        expect(AppHelpers.daySuffix(i), 'th');
      }
      for (int i = 24; i <= 30; i++) {
        expect(AppHelpers.daySuffix(i), 'th');
      }
    });
  });
}
