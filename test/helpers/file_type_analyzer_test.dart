import 'package:flutter_test/flutter_test.dart';
import 'package:writer/utils/helpers/file_type_analyzer.dart';
import 'package:writer/utils/constants/file_types.dart';

void main() {
  group('FileTypeAnalyzer.classifyExtension Tests', () {
    test('should classify markdown extensions correctly', () {
      expect(FileTypeAnalyzer.classifyExtension('md'), FileType.markdown);
      expect(FileTypeAnalyzer.classifyExtension('markdown'), FileType.markdown);
      expect(FileTypeAnalyzer.classifyExtension('MD'), FileType.markdown);
      expect(FileTypeAnalyzer.classifyExtension('MARKDOWN'), FileType.markdown);
    });

    test('should classify plain text extensions correctly', () {
      expect(FileTypeAnalyzer.classifyExtension('txt'), FileType.plainText);
      expect(FileTypeAnalyzer.classifyExtension('text'), FileType.plainText);
      expect(FileTypeAnalyzer.classifyExtension('TXT'), FileType.plainText);
    });

    test('should classify programming language extensions correctly', () {
      expect(FileTypeAnalyzer.classifyExtension('py'), FileType.programmingLanguage);
      expect(FileTypeAnalyzer.classifyExtension('js'), FileType.programmingLanguage);
      expect(FileTypeAnalyzer.classifyExtension('java'), FileType.programmingLanguage);
      expect(FileTypeAnalyzer.classifyExtension('cpp'), FileType.programmingLanguage);
      expect(FileTypeAnalyzer.classifyExtension('dart'), FileType.programmingLanguage);
    });

    test('should classify todo extensions correctly', () {
      expect(FileTypeAnalyzer.classifyExtension('todo'), FileType.todo);
      expect(FileTypeAnalyzer.classifyExtension('TODO'), FileType.todo);
    });

    test('should classify null extension as plain text', () {
      expect(FileTypeAnalyzer.classifyExtension(null), FileType.plainText);
    });

    test('should classify unknown extensions as unsupported', () {
      expect(FileTypeAnalyzer.classifyExtension('xyz'), FileType.unsupported);
      expect(FileTypeAnalyzer.classifyExtension('unknown'), FileType.unsupported);
      expect(FileTypeAnalyzer.classifyExtension('abc123'), FileType.unsupported);
    });

    test('should handle case insensitivity', () {
      expect(FileTypeAnalyzer.classifyExtension('PY'), FileType.programmingLanguage);
      expect(FileTypeAnalyzer.classifyExtension('Js'), FileType.programmingLanguage);
      expect(FileTypeAnalyzer.classifyExtension('Md'), FileType.markdown);
    });

    test('should classify common programming languages', () {
      final programmingExtensions = ['c', 'cpp', 'java', 'py', 'js', 'ts', 'rb', 'go', 'rs', 'swift', 'kt'];
      
      for (final ext in programmingExtensions) {
        expect(
          FileTypeAnalyzer.classifyExtension(ext),
          FileType.programmingLanguage,
          reason: 'Extension "$ext" should be classified as programming language',
        );
      }
    });
  });
}
