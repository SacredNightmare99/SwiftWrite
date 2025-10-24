import 'package:get/get.dart';

class TodoItem {
  String title;
  bool isDone;

  TodoItem({required this.title, this.isDone = false});
}

class TodoController extends GetxController {
  final RxList<TodoItem> todos = <TodoItem>[].obs;
  final Function(String) onMarkdownChanged;
  final String initialData;

  TodoController({required this.onMarkdownChanged, required this.initialData});

  @override
  void onInit() {
    super.onInit();
    _parseTodoData(initialData);
  }

  void _parseTodoData(String data) {
    if (data.isEmpty) {
      todos.clear();
      return;
    }
    final lines = data.split('\n');
    final parsedTodos = lines.where((line) => line.trim().startsWith('- [')).map((line) {
      final isDone = line.contains('- [x]');
      final title = line.substring(line.indexOf(']') + 1).trim();
      return TodoItem(title: title, isDone: isDone);
    }).toList();
    todos.assignAll(parsedTodos);
  }

  void updateFromMarkdown(String data) {
    if (_convertToMarkdown() != data) {
      _parseTodoData(data);
    }
  }

  String _convertToMarkdown() {
    return todos.map((todo) {
      return '- [${todo.isDone ? 'x' : ' '}] ${todo.title}';
    }).join('\n');
  }

  void _updateMarkdown() {
    onMarkdownChanged(_convertToMarkdown());
  }

  void addTodo() {
    todos.add(TodoItem(title: 'New Todo'));
    _updateMarkdown();
  }

  void removeTodoAt(int index) {
    todos.removeAt(index);
    _updateMarkdown();
  }

  void toggleTodoAt(int index) {
    todos[index].isDone = !todos[index].isDone;
    todos.refresh();
    _updateMarkdown();
  }

  void updateTodoTitle(int index, String newTitle) {
      todos[index].title = newTitle;
      _updateMarkdown();
  }
}
