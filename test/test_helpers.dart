import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:writer/data/models/note.dart';

/// Common test setup utilities
class TestHelpers {
  /// Initialize Hive for testing
  static Future<void> initializeHive() async {
    await Hive.initFlutter();
    
    // Register adapters if not already registered
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(NoteAdapter());
    }
  }

  /// Open required Hive boxes for testing
  static Future<void> openBoxes() async {
    if (!Hive.isBoxOpen('settings')) {
      await Hive.openBox('settings');
    }
    if (!Hive.isBoxOpen('notes')) {
      await Hive.openBox<Note>('notes');
    }
  }

  /// Clear all Hive boxes
  static Future<void> clearBoxes() async {
    if (Hive.isBoxOpen('settings')) {
      await Hive.box('settings').clear();
    }
    if (Hive.isBoxOpen('notes')) {
      await Hive.box<Note>('notes').clear();
    }
  }

  /// Close all Hive boxes
  static Future<void> closeBoxes() async {
    if (Hive.isBoxOpen('settings')) {
      await Hive.box('settings').close();
    }
    if (Hive.isBoxOpen('notes')) {
      await Hive.box<Note>('notes').close();
    }
  }

  /// Initialize dotenv for testing
  static void initializeDotenv() {
    dotenv.testLoad(fileInput: 'Judge0API=test_api_key');
  }

  /// Create a test note
  static Note createTestNote({
    String title = 'Test Note',
    String content = 'Test content',
    List<String> tags = const [],
    String? fileExtension,
    int? order,
  }) {
    return Note(
      title: title,
      content: content,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      tags: tags,
      fileExtension: fileExtension,
      order: order,
    );
  }

  /// Setup complete test environment
  static Future<void> setupTestEnvironment() async {
    await initializeHive();
    await openBoxes();
    initializeDotenv();
  }

  /// Teardown test environment
  static Future<void> teardownTestEnvironment() async {
    await clearBoxes();
    await closeBoxes();
  }
}
