import 'package:flutter_test/flutter_test.dart';
import 'package:writer/utils/constants/file_types.dart';

void main() {
  group('FileType Enum Tests', () {
    test('should have all expected file types', () {
      expect(FileType.values.length, 5);
      expect(FileType.values, contains(FileType.markdown));
      expect(FileType.values, contains(FileType.programmingLanguage));
      expect(FileType.values, contains(FileType.plainText));
      expect(FileType.values, contains(FileType.todo));
      expect(FileType.values, contains(FileType.unsupported));
    });
  });

  group('languageIdMap Tests', () {
    test('should contain mappings for common languages', () {
      expect(languageIdMap['cpp'], 52);
      expect(languageIdMap['java'], 62);
      expect(languageIdMap['py'], 71);
      expect(languageIdMap['js'], 63);
      expect(languageIdMap['c'], 50);
    });

    test('should have valid IDs for all languages', () {
      for (final entry in languageIdMap.entries) {
        expect(entry.value, isPositive);
        expect(entry.key, isNotEmpty);
      }
    });

    test('should include popular languages', () {
      final popularLanguages = ['cpp', 'java', 'py', 'js', 'go', 'rs', 'swift'];
      for (final lang in popularLanguages) {
        expect(languageIdMap.containsKey(lang), true, 
          reason: 'Should contain $lang');
      }
    });
  });

  group('FileTypes Constants Tests', () {
    test('markdown extensions should be defined', () {
      expect(FileTypes.markdown, isNotEmpty);
      expect(FileTypes.markdown, contains('md'));
      expect(FileTypes.markdown, contains('markdown'));
    });

    test('plainText extensions should be defined', () {
      expect(FileTypes.plainText, isNotEmpty);
      expect(FileTypes.plainText, contains('txt'));
    });

    test('programmingLanguage extensions should be defined', () {
      expect(FileTypes.programmingLanguage, isNotEmpty);
      expect(FileTypes.programmingLanguage.length, greaterThan(10));
    });

    test('programmingLanguage should include web languages', () {
      expect(FileTypes.programmingLanguage, contains('html'));
      expect(FileTypes.programmingLanguage, contains('css'));
      expect(FileTypes.programmingLanguage, contains('js'));
      expect(FileTypes.programmingLanguage, contains('ts'));
    });

    test('programmingLanguage should include compiled languages', () {
      expect(FileTypes.programmingLanguage, contains('c'));
      expect(FileTypes.programmingLanguage, contains('cpp'));
      expect(FileTypes.programmingLanguage, contains('java'));
      expect(FileTypes.programmingLanguage, contains('dart'));
      expect(FileTypes.programmingLanguage, contains('py'));
      expect(FileTypes.programmingLanguage, contains('go'));
    });

    test('todo extensions should be defined', () {
      expect(FileTypes.todo, isNotEmpty);
      expect(FileTypes.todo, contains('todo'));
    });

    test('supportedExtensions should include all categories', () {
      expect(FileTypes.supportedExtensions, isNotEmpty);
      
      // Check markdown extensions are included
      for (final ext in FileTypes.markdown) {
        expect(FileTypes.supportedExtensions, contains(ext));
      }
      
      // Check plainText extensions are included
      for (final ext in FileTypes.plainText) {
        expect(FileTypes.supportedExtensions, contains(ext));
      }
      
      // Check programmingLanguage extensions are included
      for (final ext in FileTypes.programmingLanguage) {
        expect(FileTypes.supportedExtensions, contains(ext));
      }
      
      // Check todo extensions are included
      for (final ext in FileTypes.todo) {
        expect(FileTypes.supportedExtensions, contains(ext));
      }
    });

    test('supportedExtensions should not have duplicates', () {
      final uniqueExtensions = FileTypes.supportedExtensions.toSet();
      expect(uniqueExtensions.length, FileTypes.supportedExtensions.length);
    });

    test('should support common file formats', () {
      final commonFormats = ['md', 'txt', 'py', 'js', 'java', 'cpp', 'dart'];
      for (final format in commonFormats) {
        expect(FileTypes.supportedExtensions, contains(format),
          reason: 'Should support $format files');
      }
    });
  });
}
