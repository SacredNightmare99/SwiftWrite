import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:writer/controllers/note_controller.dart';

class HomeScreen extends StatelessWidget {
  final NoteController _noteController = Get.put(NoteController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SwiftWrite'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () {
              Get.changeThemeMode(
                  Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
            },
          ),
        ],
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: _noteController.notes.length,
          itemBuilder: (context, index) {
            final note = _noteController.notes[index];
            return Dismissible(
              key: Key(note.key.toString()),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                _noteController.deleteNote(note.key);
                
                final snackBar = SnackBar(
                  content: Text('The note "${note.title}" has been deleted.'),
                  duration: Durations.short4,
                  behavior: SnackBarBehavior.floating,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 20.0),
                child: Icon(Icons.delete, color: Colors.white),
              ),
              child: ListTile(
                title: Text(note.title),
                subtitle: Text(
                  note.content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () => Get.toNamed('/writer', arguments: note),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/writer'),
        child: Icon(Icons.add),
      ),
    );
  }
}
