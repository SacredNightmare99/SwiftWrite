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
    return SafeArea(
      top: false,
      child: Scaffold(
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
                  final deletedNote = note;
                  _noteController.deleteNote(deletedNote.key);
      
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('The note "${deletedNote.title}" has been deleted.'),
                      duration: const Duration(seconds: 2),
                      dismissDirection: direction,
                      action: SnackBarAction(
                        label: "Undo",
                        onPressed: () {
                          _noteController.addNote(deletedNote);
                        },
                      ),
                    ),
                  );
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
      ),
    );
  }
}
