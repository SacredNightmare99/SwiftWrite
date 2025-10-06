import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart' hide FileType;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:writer/controllers/note_controller.dart';
import 'package:writer/data/models/note.dart';
import 'package:writer/utils/helpers/file_type_analyzer.dart';

class WriterController extends GetxController {
  final NoteController noteController = Get.find<NoteController>();

  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final tagController = TextEditingController();

  Note? existingNote;
  final isPreview = true.obs;
  final tags = <String>[].obs;
  final type = FileType.plainText.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      existingNote = Get.arguments as Note;
      titleController.text = existingNote!.title;
      contentController.text = existingNote!.content;
      tags.value = List<String>.from(existingNote!.tags);
    }
    titleController.addListener(_updateFileType);
    contentController.addListener(_updatePreviewState);
    _updateFileType();
  }

  @override
  void onClose() {
    titleController.removeListener(_updateFileType);
    contentController.removeListener(_updatePreviewState);
    titleController.dispose();
    contentController.dispose();
    tagController.dispose();
    super.onClose();
  }

  void _updateFileType() {
    final title = titleController.text;
    String? newExtension;
    if (title.contains('.')) {
      newExtension = title.split('.').last;
    }
    type.value = FileTypeAnalyzer.classifyExtension(newExtension);
    _updatePreviewState();
  }

  void _updatePreviewState() {
    if (type.value == FileType.markdown && contentController.text.isNotEmpty && isPreview.value == true) {
      isPreview.value = true;
    } else {
      isPreview.value = false;
    }
  }

  void saveNote() {
    final title = titleController.text;
    final content = contentController.text;

    if (title.isEmpty && content.isEmpty) {
      return;
    }

    String? extension;
    if (title.contains('.')) {
      extension = title.split('.').last;
    }

    final fileType = FileTypeAnalyzer.classifyExtension(extension);
    String? finalExtension;

    if (extension == null || fileType == FileType.unsupported) {
      finalExtension = 'txt';
    } else {
      finalExtension = extension;
    }

    if (existingNote != null) {
      final isNewNote = !noteController.notes.any((note) => note.key == existingNote!.key);

      existingNote!.title = title;
      existingNote!.content = content;
      existingNote!.updatedAt = DateTime.now();
      existingNote!.tags = tags;
      existingNote!.fileExtension = finalExtension;

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
        fileExtension: finalExtension,
      );
      noteController.addNote(newNote);
    }
  }

  Future<void> shareNote() async {
    final rawTitle = titleController.text.trim();
    final content = contentController.text;
    final dir = await getTemporaryDirectory();

    String fileName = rawTitle.isNotEmpty ? rawTitle : 'note';
    String? extension;

    if (fileName.contains('.')) {
      extension = fileName.split('.').last;
    }

    final fileType = FileTypeAnalyzer.classifyExtension(extension);
    if (extension == null || fileType == FileType.unsupported) {
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
    String? extension;

    if (fileName.contains('.')) {
      extension = fileName.split('.').last;
    }

    final fileType = FileTypeAnalyzer.classifyExtension(extension);
    if (extension == null || fileType == FileType.unsupported) {
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
