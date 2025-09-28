import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:writer/controllers/note_controller.dart';
import 'package:writer/data/services/theme_service.dart';
import 'package:writer/utils/widgets/note_tile.dart';

class HomeScreen extends StatelessWidget {
  final NoteController _noteController = Get.put(NoteController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SwiftWrite'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () => ThemeService().switchTheme(),
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
                  duration: Duration(seconds: 5),
                  behavior: SnackBarBehavior.floating,
                  dismissDirection: direction,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20.0),
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.error,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Icon(Icons.delete, color: Theme.of(context).colorScheme.onError),
              ),
              child: NoteTile(
                note: note,
                onTap: () => Get.toNamed('/writer', arguments: note),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/writer'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
