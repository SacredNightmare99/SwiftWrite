import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:writer/controllers/note_controller.dart';
import 'package:writer/data/models/note.dart';

class WriterController extends GetxController {
  final NoteController noteController = Get.find();

  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final tagController = TextEditingController();

  Note? existingNote;
  final isPreview = true.obs;
  final tags = <String>[].obs;
  final type = Rx<String?>(null);

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      existingNote = Get.arguments as Note;
      titleController.text = existingNote!.title;
      contentController.text = existingNote!.content;
      tags.value = List<String>.from(existingNote!.tags);
      type.value = existingNote!.fileExtension;
    }
    titleController.addListener(_updateFileType);
  }

  @override
  void onClose() {
    titleController.removeListener(_updateFileType);
    titleController.dispose();
    contentController.dispose();
    tagController.dispose();
    super.onClose();
  }

  void _updateFileType() {
    final title = titleController.text;
    String? newType;
    if (title.contains('.')) {
      newType = title.split('.').last;
    }
    if (newType != type.value) {
      type.value = newType;
    }
  }

  void saveNote() {
    final title = titleController.text;
    final content = contentController.text;

    if (title.isEmpty && content.isEmpty) {
      return;
    }

    if (existingNote != null) {
      final isNewNote = !noteController.notes.any((note) => note.key == existingNote!.key);

      existingNote!.title = title;
      existingNote!.content = content;
      existingNote!.updatedAt = DateTime.now();
      existingNote!.tags = tags;
      if (title.contains('.')) {
        existingNote!.fileExtension = title.split('.').last;
      } else {
        existingNote!.fileExtension = null;
      }

      if (isNewNote) {
        noteController.addNote(existingNote!);
      } else {
        noteController.updateNote(existingNote!.key, existingNote!);
      }
    } else {
      final newNote = Note(
        title: title.isEmpty ? "New Note" : title,
        content: content,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        tags: tags,
        fileExtension: title.contains('.') ? title.split('.').last : null,
      );
      noteController.addNote(newNote);
    }
  }

  Future<void> shareNote() async {
    final rawTitle = titleController.text.trim();
    final content = contentController.text;
    final dir = await getTemporaryDirectory();

    String fileName = rawTitle.isNotEmpty ? rawTitle : 'note';
    final fileExtension = existingNote?.fileExtension;
    if (fileExtension != null && !fileName.endsWith('.$fileExtension')) {
      fileName = '$fileName.$fileExtension';
    } else if (fileExtension == null && !fileName.contains('.')) {
      fileName = '$fileName.txt';
    }

    final file = File('${dir.path}/$fileName');
    await file.writeAsString(content);

    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path)],
        text: 'Sharing: $fileName',
      ),
    );
  }

  Future<void> saveNoteToFile(BuildContext context) async {
    final rawTitle = titleController.text.trim();
    final content = contentController.text;

    String fileName = rawTitle.isNotEmpty ? rawTitle : 'note';
    final fileExtension = existingNote?.fileExtension;
    if (fileExtension != null && !fileName.endsWith('.$fileExtension')) {
      fileName = '$fileName.$fileExtension';
    } else if (fileExtension == null && !fileName.contains('.')) {
      fileName = '$fileName.txt';
    }

    try {
      final result = await FilePicker.platform.saveFile(
        dialogTitle: 'Save your note',
        fileName: fileName,
        bytes: Uint8List.fromList(content.codeUnits),
      );

      if (result != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Note saved'),
          ),
        );
      }
    } catch (e) {
      throw Exception("Error saving note: $e");
    }
  }

  void addTag(String tag) {
    final newTag = tag.trim();
    if (newTag.isNotEmpty && !tags.contains(newTag)) {
      tags.add(newTag);
      tagController.clear();
    }
  }

  void removeTag(String tag) {
    tags.remove(tag);
  }

  void togglePreview() {
    isPreview.toggle();
  }
}
