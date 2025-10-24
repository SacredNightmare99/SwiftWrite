import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:writer/controllers/todo_controller.dart';

class TodoScreen extends StatelessWidget {
  final String data;
  final ValueChanged<String> onChanged;

  const TodoScreen({super.key, required this.data, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final TodoController controller = Get.put(
      TodoController(onMarkdownChanged: onChanged, initialData: data),
    );
    controller.updateFromMarkdown(data);

    return Scaffold(
      body: Obx(
        () => ListView.builder(
          itemCount: controller.todos.length,
          itemBuilder: (context, index) {
            final todo = controller.todos[index];
            return ListTile(
              leading: Checkbox(
                value: todo.isDone,
                onChanged: (value) => controller.toggleTodoAt(index),
              ),
              title: TextFormField(
                initialValue: todo.title,
                onChanged: (value) {
                  controller.updateTodoTitle(index, value);
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => controller.removeTodoAt(index),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.addTodo,
        child: const Icon(Icons.add),
      ),
    );
  }
}