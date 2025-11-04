import 'package:flutter_test/flutter_test.dart';
import 'package:writer/utils/helpers/file_helper.dart';

void main() {
  group('FileHelper.prepareFileName Tests', () {
    test('should return filename with extension when both provided', () {
      final result = FileHelper.prepareFileName('document', 'txt');
      expect(result, 'document.txt');
    });

    test('should not duplicate extension if already present', () {
      final result = FileHelper.prepareFileName('document.txt', 'txt');
      expect(result, 'document.txt');
    });

    test('should add default .txt extension when no extension provided', () {
      final result = FileHelper.prepareFileName('document', null);
      expect(result, 'document.txt');
    });

    test('should use existing extension in filename when no extension param', () {
      final result = FileHelper.prepareFileName('document.md', null);
      expect(result, 'document.md');
    });

    test('should handle empty title with default "note"', () {
      final result = FileHelper.prepareFileName('', 'txt');
      expect(result, 'note.txt');
    });

    test('should handle empty title and null extension', () {
      final result = FileHelper.prepareFileName('', null);
      expect(result, 'note.txt');
    });

    test('should handle various extensions correctly', () {
      expect(FileHelper.prepareFileName('code', 'py'), 'code.py');
      expect(FileHelper.prepareFileName('readme', 'md'), 'readme.md');
      expect(FileHelper.prepareFileName('todo', 'todo'), 'todo.todo');
    });
  });

  group('FileHelper.extractExtension Tests', () {
    test('should extract extension from filename', () {
      expect(FileHelper.extractExtension('document.txt'), 'txt');
      expect(FileHelper.extractExtension('file.md'), 'md');
      expect(FileHelper.extractExtension('script.py'), 'py');
    });

    test('should return null when no extension present', () {
      expect(FileHelper.extractExtension('document'), isNull);
      expect(FileHelper.extractExtension('noextension'), isNull);
    });

    test('should handle multiple dots correctly', () {
      expect(FileHelper.extractExtension('archive.tar.gz'), 'gz');
      expect(FileHelper.extractExtension('file.backup.txt'), 'txt');
    });

    test('should handle edge cases', () {
      expect(FileHelper.extractExtension('.hiddenfile'), 'hiddenfile');
      expect(FileHelper.extractExtension('file.'), '');
    });
  });

  group('FileHelper.determineFinalExtension Tests', () {
    test('should return existing extension when valid', () {
      final result = FileHelper.determineFinalExtension('doc', 'txt');
      expect(result, 'txt');
    });

    test('should extract extension from title when no existing extension', () {
      final result = FileHelper.determineFinalExtension('doc.md', null);
      expect(result, 'md');
    });

    test('should return "txt" for unsupported extensions', () {
      final result = FileHelper.determineFinalExtension('file', 'xyz');
      expect(result, 'txt');
    });

    test('should return "txt" when no extension at all', () {
      final result = FileHelper.determineFinalExtension('file', null);
      expect(result, 'txt');
    });

    test('should return "todo" for todo files', () {
      final result = FileHelper.determineFinalExtension('tasks', 'todo');
      expect(result, 'todo');
    });

    test('should handle markdown extensions', () {
      expect(FileHelper.determineFinalExtension('readme', 'md'), 'md');
      expect(FileHelper.determineFinalExtension('readme', 'markdown'), 'markdown');
    });

    test('should handle programming language extensions', () {
      expect(FileHelper.determineFinalExtension('script', 'py'), 'py');
      expect(FileHelper.determineFinalExtension('app', 'js'), 'js');
    });
  });
}
