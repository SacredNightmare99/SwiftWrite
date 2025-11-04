import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:writer/utils/widgets/tag_editor.dart';

void main() {
  group('TagEditor Widget Tests', () {
    late TextEditingController tagController;
    late RxList<String> tags;

    setUp(() {
      tagController = TextEditingController();
      tags = <String>[].obs;
    });

    tearDown(() {
      tagController.dispose();
    });

    testWidgets('should display existing tags', (WidgetTester tester) async {
      tags.addAll(['flutter', 'dart', 'testing']);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TagEditor(
              tags: tags,
              tagController: tagController,
              onAddTag: (_) {},
              onRemoveTag: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('flutter'), findsOneWidget);
      expect(find.text('dart'), findsOneWidget);
      expect(find.text('testing'), findsOneWidget);
      expect(find.byType(Chip), findsNWidgets(3));
    });

    testWidgets('should display text field with hint', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TagEditor(
              tags: tags,
              tagController: tagController,
              onAddTag: (_) {},
              onRemoveTag: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Add a tag...'), findsOneWidget);
    });

    testWidgets('should call onAddTag when text submitted', (WidgetTester tester) async {
      String? addedTag;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TagEditor(
              tags: tags,
              tagController: tagController,
              onAddTag: (tag) => addedTag = tag,
              onRemoveTag: (_) {},
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'newtag');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(addedTag, 'newtag');
    });

    testWidgets('should call onRemoveTag when chip deleted', (WidgetTester tester) async {
      tags.addAll(['flutter', 'dart']);
      String? removedTag;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TagEditor(
              tags: tags,
              tagController: tagController,
              onAddTag: (_) {},
              onRemoveTag: (tag) => removedTag = tag,
            ),
          ),
        ),
      );

      // Find the delete icon on the first chip
      await tester.tap(find.byIcon(Icons.cancel).first);
      await tester.pump();

      expect(removedTag, isNotNull);
      expect(['flutter', 'dart'], contains(removedTag));
    });

    testWidgets('should update display when tags change', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TagEditor(
              tags: tags,
              tagController: tagController,
              onAddTag: (_) {},
              onRemoveTag: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(Chip), findsNothing);

      // Add a tag
      tags.add('newtag');
      await tester.pump();

      expect(find.byType(Chip), findsOneWidget);
      expect(find.text('newtag'), findsOneWidget);
    });

    testWidgets('should handle empty tags list', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TagEditor(
              tags: tags,
              tagController: tagController,
              onAddTag: (_) {},
              onRemoveTag: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(Chip), findsNothing);
      expect(find.byType(TextField), findsOneWidget);
    });
  });
}
