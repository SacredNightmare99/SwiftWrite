import 'package:flutter_test/flutter_test.dart';
import 'package:writer/controllers/todo_controller.dart';
import 'package:writer/data/models/todo_list_item.dart';

void main() {
  group('TodoController Tests', () {
    test('should parse empty data correctly', () {
      String? lastMarkdown;
      final controller = TodoController(
        onMarkdownChanged: (markdown) => lastMarkdown = markdown,
        initialData: '',
      );
      controller.onInit();

      expect(controller.items.length, 0);
    });

    test('should parse checklist items correctly', () {
      String? lastMarkdown;
      final controller = TodoController(
        onMarkdownChanged: (markdown) => lastMarkdown = markdown,
        initialData: '- [ ] Task 1\n- [x] Task 2',
      );
      controller.onInit();

      expect(controller.items.length, 2);
      
      final item1 = controller.items[0] as ChecklistItem;
      expect(item1.title, 'Task 1');
      expect(item1.isDone, false);
      
      final item2 = controller.items[1] as ChecklistItem;
      expect(item2.title, 'Task 2');
      expect(item2.isDone, true);
    });

    test('should parse markdown items correctly', () {
      String? lastMarkdown;
      final controller = TodoController(
        onMarkdownChanged: (markdown) => lastMarkdown = markdown,
        initialData: '# Title\nRegular text',
      );
      controller.onInit();

      expect(controller.items.length, 2);
      expect(controller.items[0], isA<MarkdownItem>());
      expect((controller.items[0] as MarkdownItem).markdownText, '# Title');
      expect(controller.items[1], isA<MarkdownItem>());
      expect((controller.items[1] as MarkdownItem).markdownText, 'Regular text');
    });

    test('should parse mixed items correctly', () {
      String? lastMarkdown;
      final controller = TodoController(
        onMarkdownChanged: (markdown) => lastMarkdown = markdown,
        initialData: '# Todo List\n- [ ] Buy milk\n- [x] Walk dog',
      );
      controller.onInit();

      expect(controller.items.length, 3);
      expect(controller.items[0], isA<MarkdownItem>());
      expect(controller.items[1], isA<ChecklistItem>());
      expect(controller.items[2], isA<ChecklistItem>());
    });

    test('should add new todo item', () {
      String? lastMarkdown;
      final controller = TodoController(
        onMarkdownChanged: (markdown) => lastMarkdown = markdown,
        initialData: '- [ ] Task 1',
      );
      controller.onInit();

      expect(controller.items.length, 1);
      
      controller.addTodo();
      
      expect(controller.items.length, 2);
      expect(controller.items[1], isA<ChecklistItem>());
      expect((controller.items[1] as ChecklistItem).title, 'New Todo');
      expect(lastMarkdown, isNotNull);
    });

    test('should remove todo item', () {
      String? lastMarkdown;
      final controller = TodoController(
        onMarkdownChanged: (markdown) => lastMarkdown = markdown,
        initialData: '- [ ] Task 1\n- [ ] Task 2',
      );
      controller.onInit();

      expect(controller.items.length, 2);
      
      controller.removeTodoAt(0);
      
      expect(controller.items.length, 1);
      final remaining = controller.items[0] as ChecklistItem;
      expect(remaining.title, 'Task 2');
      expect(lastMarkdown, contains('Task 2'));
    });

    test('should toggle todo completion status', () {
      String? lastMarkdown;
      final controller = TodoController(
        onMarkdownChanged: (markdown) => lastMarkdown = markdown,
        initialData: '- [ ] Task 1',
      );
      controller.onInit();

      final item = controller.items[0] as ChecklistItem;
      expect(item.isDone, false);
      
      controller.toggleTodoAt(0);
      
      expect(item.isDone, true);
      expect(lastMarkdown, contains('- [x] Task 1'));
    });

    test('should update todo title', () {
      String? lastMarkdown;
      final controller = TodoController(
        onMarkdownChanged: (markdown) => lastMarkdown = markdown,
        initialData: '- [ ] Old Title',
      );
      controller.onInit();

      controller.updateTodoTitle(0, 'New Title');
      
      final item = controller.items[0] as ChecklistItem;
      expect(item.title, 'New Title');
      expect(lastMarkdown, contains('New Title'));
    });

    test('should reorder items correctly', () {
      String? lastMarkdown;
      final controller = TodoController(
        onMarkdownChanged: (markdown) => lastMarkdown = markdown,
        initialData: '- [ ] Task 1\n- [ ] Task 2\n- [ ] Task 3',
      );
      controller.onInit();

      controller.reorderItems(0, 2);
      
      final item1 = controller.items[0] as ChecklistItem;
      final item2 = controller.items[1] as ChecklistItem;
      expect(item1.title, 'Task 2');
      expect(item2.title, 'Task 1');
      expect(lastMarkdown, isNotNull);
    });

    test('should convert items to markdown correctly', () {
      String? lastMarkdown;
      final controller = TodoController(
        onMarkdownChanged: (markdown) => lastMarkdown = markdown,
        initialData: '# Header\n- [ ] Task 1\n- [x] Task 2',
      );
      controller.onInit();

      controller.addTodo();
      
      expect(lastMarkdown, contains('# Header'));
      expect(lastMarkdown, contains('- [ ] Task 1'));
      expect(lastMarkdown, contains('- [x] Task 2'));
      expect(lastMarkdown, contains('- [ ] New Todo'));
    });

    test('should not trigger markdown change if already in sync', () {
      int callCount = 0;
      final controller = TodoController(
        onMarkdownChanged: (markdown) => callCount++,
        initialData: '- [ ] Task 1',
      );
      controller.onInit();

      final initialCallCount = callCount;
      
      controller.updateFromMarkdown('- [ ] Task 1');
      
      expect(callCount, initialCallCount);
    });

    test('should update from markdown when different', () {
      String? lastMarkdown;
      final controller = TodoController(
        onMarkdownChanged: (markdown) => lastMarkdown = markdown,
        initialData: '- [ ] Task 1',
      );
      controller.onInit();

      controller.updateFromMarkdown('- [ ] New Task');
      
      expect(controller.items.length, 1);
      final item = controller.items[0] as ChecklistItem;
      expect(item.title, 'New Task');
    });
  });
}
