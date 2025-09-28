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
              ? Markdown(
                  data: _contentController.text,
                  styleSheet: _getMarkdownStyleSheet(),
                )
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

  MarkdownStyleSheet _getMarkdownStyleSheet() {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return MarkdownStyleSheet(
      a: TextStyle(
        color: colorScheme.primary,
        decoration: TextDecoration.underline,
      ),
      p: textTheme.bodyLarge,
      pPadding: const EdgeInsets.symmetric(vertical: 4),
      h1: textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
      h1Padding: const EdgeInsets.symmetric(vertical: 8),
      h2: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
      h2Padding: const EdgeInsets.symmetric(vertical: 6),
      h3: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
      h3Padding: const EdgeInsets.symmetric(vertical: 4),
      h4: textTheme.titleLarge,
      h4Padding: const EdgeInsets.symmetric(vertical: 4),
      h5: textTheme.titleMedium,
      h5Padding: const EdgeInsets.symmetric(vertical: 2),
      h6: textTheme.titleSmall,
      h6Padding: const EdgeInsets.symmetric(vertical: 2),
      em: const TextStyle(fontStyle: FontStyle.italic),
      strong: const TextStyle(fontWeight: FontWeight.bold),
      del: const TextStyle(decoration: TextDecoration.lineThrough),
      blockquote: textTheme.bodyMedium?.copyWith(
        fontStyle: FontStyle.italic,
        color: textTheme.bodyMedium?.color?.withOpacity(0.7),
      ),
      blockquoteDecoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: theme.dividerColor, width: 4)),
      ),
      code: textTheme.bodyMedium?.copyWith(
        fontFamily: 'monospace',
        backgroundColor: theme.cardColor,
      ),
      codeblockDecoration: BoxDecoration(
        color: colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: theme.dividerColor),
      ),
      blockSpacing: 8.0,
      listIndent: 24.0,
      listBullet: const TextStyle(fontSize: 16),
      checkbox: const TextStyle(fontSize: 16),
      unorderedListAlign: WrapAlignment.start,
      orderedListAlign: WrapAlignment.start,
      tableHead: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      tableBody: textTheme.bodyMedium,
      tableBorder: TableBorder.all(color: theme.dividerColor),
      tableColumnWidth: const IntrinsicColumnWidth(),
      tableCellsDecoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: theme.dividerColor),
          right: BorderSide(color: theme.dividerColor),
          bottom: BorderSide(color: theme.dividerColor),
          left: BorderSide(color: theme.dividerColor),
        ),
      ),
      tableCellsPadding: const EdgeInsets.all(6),
      horizontalRuleDecoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: theme.dividerColor),
        ),
      ),
      img: textTheme.bodyMedium,
    );
  }
}
