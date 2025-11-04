import 'package:flutter_test/flutter_test.dart';
import 'package:writer/data/models/note.dart';

void main() {
  group('Note Model Tests', () {
    test('should create a Note with required fields', () {
      final now = DateTime.now();
      final note = Note(
        title: 'Test Note',
        content: 'Test content',
        createdAt: now,
        updatedAt: now,
      );

      expect(note.title, 'Test Note');
      expect(note.content, 'Test content');
      expect(note.createdAt, now);
      expect(note.updatedAt, now);
      expect(note.tags, isEmpty);
      expect(note.order, isNull);
      expect(note.fileExtension, isNull);
    });

    test('should create a Note with all fields', () {
      final now = DateTime.now();
      final note = Note(
        title: 'Full Note',
        content: 'Full content',
        createdAt: now,
        updatedAt: now,
        tags: ['tag1', 'tag2'],
        order: 5,
        fileExtension: 'md',
      );

      expect(note.title, 'Full Note');
      expect(note.content, 'Full content');
      expect(note.tags, ['tag1', 'tag2']);
      expect(note.order, 5);
      expect(note.fileExtension, 'md');
    });

    test('should have empty tags list by default', () {
      final now = DateTime.now();
      final note = Note(
        title: 'Note',
        content: 'Content',
        createdAt: now,
        updatedAt: now,
      );

      expect(note.tags, isNotNull);
      expect(note.tags, isEmpty);
    });

    test('should allow modification of title', () {
      final now = DateTime.now();
      final note = Note(
        title: 'Original',
        content: 'Content',
        createdAt: now,
        updatedAt: now,
      );

      note.title = 'Modified';
      expect(note.title, 'Modified');
    });

    test('should allow modification of content', () {
      final now = DateTime.now();
      final note = Note(
        title: 'Title',
        content: 'Original',
        createdAt: now,
        updatedAt: now,
      );

      note.content = 'Modified Content';
      expect(note.content, 'Modified Content');
    });

    test('should allow adding tags', () {
      final now = DateTime.now();
      final note = Note(
        title: 'Title',
        content: 'Content',
        createdAt: now,
        updatedAt: now,
        tags: ['tag1'],
      );

      note.tags.add('tag2');
      expect(note.tags.length, 2);
      expect(note.tags, contains('tag2'));
    });
  });
}
