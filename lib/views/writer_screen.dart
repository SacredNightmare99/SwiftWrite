import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:writer/controllers/note_controller.dart';
import 'package:writer/data/models/note.dart';

class WriterScreen extends StatefulWidget {
  const WriterScreen({super.key});

  @override
  WriterScreenState createState() => WriterScreenState();
}

class WriterScreenState extends State<WriterScreen> {
  final NoteController _noteController = Get.find();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  Note? _existingNote;
  bool _isPreview = false;

  @override
  void initState() {
    super.initState();
    if (Get.arguments != null) {
      _existingNote = Get.arguments as Note;
      _titleController.text = _existingNote!.title;
      _contentController.text = _existingNote!.content;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveNote() {
    final title = _titleController.text;
    final content = _contentController.text;

    if (title.isEmpty && content.isEmpty) {
      return;
    }

    if (_existingNote != null) {
      _existingNote!.title = title;
      _existingNote!.content = content;
      _existingNote!.updatedAt = DateTime.now();
      _noteController.updateNote(_existingNote!.key, _existingNote!);
    } else {
      final newNote = Note(
        title: title.isEmpty ? "New Note" : title,
        content: content,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      _noteController.addNote(newNote);
    }
  }

  void _shareNote() {
    final title = _titleController.text;
    final content = _contentController.text;

    if (content.isNotEmpty) {
      Share.share(content, subject: title);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) _saveNote();
      },
      child: Scaffold(
        appBar: AppBar(
          title: _isPreview
              ? Text(_titleController.text)
              : TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    border: InputBorder.none,
                  ),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
          actions: [
            IconButton(
              icon: Icon(_isPreview ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  _isPreview = !_isPreview;
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: _shareNote,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _isPreview
              ? Markdown(data: _contentController.text)
              : TextField(
                  controller: _contentController,
                  maxLines: null,
                  expands: true,
                  decoration: const InputDecoration(
                    hintText: 'Start writing...',
                    border: InputBorder.none,
                  ),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
        ),
      ),
    );
  }
}
