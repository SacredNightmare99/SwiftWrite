import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:writer/data/models/note.dart';
import 'package:writer/utils/widgets/note_tile.dart';

void main() {
  group('NoteTile Widget Tests', () {
    late Note testNote;

    setUp(() {
      testNote = Note(
        title: 'Test Note',
        content: 'Test content',
        createdAt: DateTime(2024, 11, 1, 10, 30),
        updatedAt: DateTime(2024, 11, 1, 14, 30),
        tags: ['flutter', 'testing'],
        fileExtension: 'md',
      );
    });

    testWidgets('should display note title', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NoteTile(
              note: testNote,
              index: 0,
            ),
          ),
        ),
      );

      expect(find.text('Test Note'), findsOneWidget);
    });

    testWidgets('should display note tags', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NoteTile(
              note: testNote,
              index: 0,
            ),
          ),
        ),
      );

      expect(find.text('flutter'), findsOneWidget);
      expect(find.text('testing'), findsOneWidget);
    });

    testWidgets('should display file extension', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NoteTile(
              note: testNote,
              index: 0,
            ),
          ),
        ),
      );

      expect(find.text('MD'), findsOneWidget);
    });

    testWidgets('should display default TXT when no extension', (WidgetTester tester) async {
      final noteWithoutExtension = Note(
        title: 'No Extension',
        content: 'Content',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NoteTile(
              note: noteWithoutExtension,
              index: 0,
            ),
          ),
        ),
      );

      expect(find.text('TXT'), findsOneWidget);
    });

    testWidgets('should not display tags section when no tags', (WidgetTester tester) async {
      final noteWithoutTags = Note(
        title: 'No Tags',
        content: 'Content',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NoteTile(
              note: noteWithoutTags,
              index: 0,
            ),
          ),
        ),
      );

      // Should still display the title
      expect(find.text('No Tags'), findsOneWidget);
      // But no tag chips
      expect(find.byType(Chip), findsOneWidget); // Only the extension chip
    });

    testWidgets('should call onTap when tapped', (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NoteTile(
              note: testNote,
              index: 0,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(NoteTile));
      await tester.pump();

      expect(tapped, true);
    });

    testWidgets('should call onLongPress when long pressed', (WidgetTester tester) async {
      bool longPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NoteTile(
              note: testNote,
              index: 0,
              onLongPress: () => longPressed = true,
            ),
          ),
        ),
      );

      await tester.longPress(find.byType(NoteTile));
      await tester.pump();

      expect(longPressed, true);
    });

    testWidgets('should display drag handle', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NoteTile(
              note: testNote,
              index: 0,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.drag_handle_sharp), findsOneWidget);
    });

    testWidgets('should be wrapped in Card', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NoteTile(
              note: testNote,
              index: 0,
            ),
          ),
        ),
      );

      expect(find.byType(Card), findsOneWidget);
    });
  });
}
