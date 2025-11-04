import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:writer/main.dart';
import 'package:writer/data/models/note.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Integration tests for core app workflows
void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    
    await Hive.initFlutter();
    
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(NoteAdapter());
    }
    
    dotenv.testLoad(fileInput: 'Judge0API=test_api_key');
  });

  setUp(() async {
    // Clear boxes before each test
    if (Hive.isBoxOpen('settings')) {
      await Hive.box('settings').clear();
    } else {
      await Hive.openBox('settings');
    }
    
    if (Hive.isBoxOpen('notes')) {
      await Hive.box<Note>('notes').clear();
    } else {
      await Hive.openBox<Note>('notes');
    }
  });

  tearDownAll(() async {
    await Hive.close();
  });

  group('App Navigation Tests', () {
    testWidgets('should navigate through app without errors', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // App should start and display home screen
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });

  group('Theme Tests', () {
    testWidgets('app should support light and dark themes', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      
      // Both themes should be defined
      expect(materialApp.theme, isNotNull);
      expect(materialApp.darkTheme, isNotNull);
    });
  });

  group('Data Persistence Tests', () {
    testWidgets('settings box should be accessible', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      expect(Hive.isBoxOpen('settings'), true);
    });

    testWidgets('notes box should be accessible', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      expect(Hive.isBoxOpen('notes'), true);
    });
  });
}
