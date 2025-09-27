import 'package:get/get.dart';
import 'package:writer/data/models/note.dart';
import 'package:writer/data/services/database_service.dart';

class NoteController extends GetxController {
  final DatabaseService _databaseService = DatabaseService();
  var notes = <Note>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllNotes();
  }

  void fetchAllNotes() {
    notes.value = _databaseService.getAllNotes();
  }

  void addNote(Note note) {
    _databaseService.addNote(note);
    fetchAllNotes();
  }

  void updateNote(dynamic key, Note note) {
    _databaseService.updateNote(key, note);
    fetchAllNotes();
  }

  void deleteNote(dynamic key) {
    _databaseService.deleteNote(key);
    fetchAllNotes();
  }
}
