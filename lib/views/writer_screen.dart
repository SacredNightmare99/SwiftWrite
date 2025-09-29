import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:writer/controllers/note_controller.dart';
import 'package:writer/data/models/note.dart';
import 'package:writer/utils/widgets/markdown_view.dart';

class WriterScreen extends StatefulWidget {
  const WriterScreen({super.key});

  @override
  WriterScreenState createState() => WriterScreenState();
}

class WriterScreenState extends State<WriterScreen> {
  final NoteController _noteController = Get.find();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  Note? _existingNote;
  bool _isPreview = false;
  List<String> _tags = [];

  @override
  void initState() {
    super.initState();
    if (Get.arguments != null) {
      _existingNote = Get.arguments as Note;
      _titleController.text = _existingNote!.title;
      _contentController.text = _existingNote!.content;
      _tags = List<String>.from(_existingNote!.tags);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  void _saveNote() {
    final title = _titleController.text;
    final content = _contentController.text;

    if (title.isEmpty && content.isEmpty) {
      return;
    }

    if (_existingNote != null) {
      final isNewNote = !_noteController.notes.any((note) => note.key == _existingNote!.key);

      _existingNote!.title = title;
      _existingNote!.content = content;
      _existingNote!.updatedAt = DateTime.now();
      _existingNote!.tags = _tags;

      if (isNewNote) {
        _noteController.addNote(_existingNote!);
      } else {
        _noteController.updateNote(_existingNote!.key, _existingNote!);
      }
    } else {
      final newNote = Note(
        title: title.isEmpty ? "New Note" : title,
        content: content,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        tags: _tags,
      );
      _noteController.addNote(newNote);
    }
  }

  Future<void> _shareNote() async {
    final rawTitle = _titleController.text.trim();
    final content = _contentController.text;
    final dir = await getTemporaryDirectory();

    String fileName = rawTitle.isNotEmpty ? rawTitle : 'note';
    if (!fileName.contains('.')) {
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

  Future<void> _saveNoteToFile() async {
    final rawTitle = _titleController.text.trim();
    final content = _contentController.text;

    String fileName = rawTitle.isNotEmpty ? rawTitle : 'note';
    if (!fileName.contains('.')) {
      fileName = '$fileName.txt';
    }

    try {
      final result = await FilePicker.platform.saveFile(
        dialogTitle: 'Save your note',
        fileName: fileName,
        bytes: Uint8List.fromList(content.codeUnits),
      );

      if (result != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Note saved'),
          ),
        );
      }
    } catch (e) {
      throw Exception("Error saving note: $e");
    }
  }

  void _addTag(String tag) {
    final newTag = tag.trim();
    if (newTag.isNotEmpty && !_tags.contains(newTag)) {
      setState(() {
        _tags.add(newTag);
        _tagController.clear();
      });
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) _saveNote();
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(
            title: _isPreview
                ? Text(_titleController.text)
                : TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      hintText: 'Title',
                      border: InputBorder.none,
                      filled: false
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
                icon: const Icon(Icons.save),
                onPressed: _saveNoteToFile,
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
            ? MarkdownView(
                data: _contentController.text,
              )
            : Column(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _contentController,
                      maxLines: null,
                      expands: true,
                      decoration: const InputDecoration(
                        hintText: 'Start writing...',
                        border: InputBorder.none,
                        filled: false
                      ),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: _tags.map((tag) {
                      return Chip(
                        label: Text(tag),
                        onDeleted: () => _removeTag(tag),
                      );
                    }).toList(),
                  ),
                  TextField(
                    controller: _tagController,
                    decoration: const InputDecoration(
                      hintText: 'Add a tag...',
                    ),
                    onSubmitted: _addTag,
                  ),
                ],
              ),
          ),
        ),
      ),
    );
  }

}
