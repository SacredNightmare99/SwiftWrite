import 'package:hive/hive.dart';
import 'package:writer/data/models/note.dart';

class DatabaseService {
  final Box<Note> _noteBox = Hive.box<Note>('notes');

  Future<void> addNote(Note note) async {
    await _noteBox.add(note);
  }

  Future<void> updateNote(dynamic key, Note note) async {
    await _noteBox.put(key, note);
  }

  Future<void> deleteNote(dynamic key) async {
    await _noteBox.delete(key);
  }

  List<Note> getAllNotes() {
    final notes = _noteBox.values.toList();
    notes.sort((a, b) => (a.order ?? 0).compareTo(b.order ?? 0));
    return notes;
  }
}
