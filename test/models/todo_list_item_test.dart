import 'package:flutter_test/flutter_test.dart';
import 'package:writer/data/models/todo_list_item.dart';

void main() {
  group('MarkdownItem Tests', () {
    test('should create a MarkdownItem with text', () {
      final item = MarkdownItem('# Hello World');

      expect(item.markdownText, '# Hello World');
      expect(item, isA<TodoListItem>());
    });

    test('should handle empty markdown text', () {
      final item = MarkdownItem('');

      expect(item.markdownText, '');
    });

    test('should handle multiline markdown', () {
      final text = '# Title\n\nParagraph content';
      final item = MarkdownItem(text);

      expect(item.markdownText, text);
    });
  });

  group('ChecklistItem Tests', () {
    test('should create a ChecklistItem with title', () {
      final item = ChecklistItem(title: 'Buy groceries');

      expect(item.title, 'Buy groceries');
      expect(item.isDone, false);
      expect(item, isA<TodoListItem>());
    });

    test('should create a ChecklistItem with isDone set to true', () {
      final item = ChecklistItem(title: 'Completed task', isDone: true);

      expect(item.title, 'Completed task');
      expect(item.isDone, true);
    });

    test('should default isDone to false', () {
      final item = ChecklistItem(title: 'New task');

      expect(item.isDone, false);
    });

    test('should allow toggling isDone', () {
      final item = ChecklistItem(title: 'Task');

      expect(item.isDone, false);
      
      item.isDone = true;
      expect(item.isDone, true);
      
      item.isDone = false;
      expect(item.isDone, false);
    });

    test('should allow modifying title', () {
      final item = ChecklistItem(title: 'Original');

      item.title = 'Modified';
      expect(item.title, 'Modified');
    });
  });
}
