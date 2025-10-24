abstract class TodoListItem {}

class MarkdownItem extends TodoListItem {
  final String markdownText;

  MarkdownItem(this.markdownText);
}

class ChecklistItem extends TodoListItem {
  String title;
  bool isDone;

  ChecklistItem({required this.title, this.isDone = false});
}
