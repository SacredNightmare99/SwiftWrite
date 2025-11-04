// This is the main widget test file for the SwiftWrite app.
// It verifies that the app starts correctly and displays the expected UI elements.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:writer/main.dart';
import 'package:writer/data/models/note.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    
    // Initialize Hive for testing
    await Hive.initFlutter();
    
    // Register adapters
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(NoteAdapter());
    }
    
    // Open boxes if not already open
    if (!Hive.isBoxOpen('settings')) {
      await Hive.openBox('settings');
    }
    if (!Hive.isBoxOpen('notes')) {
      await Hive.openBox<Note>('notes');
    }

    // Initialize dotenv for testing
    dotenv.testLoad(fileInput: 'Judge0API=test_api_key');
  });

  tearDownAll(() async {
    // Clean up after tests
    await Hive.close();
  });

  testWidgets('MyApp initializes and displays correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verify that the app initialized without errors
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('App should have SwiftWrite title', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // The MaterialApp should have the title
    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.title, 'SwiftWrite');
  });

  testWidgets('App should not show debug banner', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.debugShowCheckedModeBanner, false);
  });
}
