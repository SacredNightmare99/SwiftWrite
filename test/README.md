# SwiftWrite Tests

This directory contains comprehensive tests for the SwiftWrite Flutter application.

## Test Structure

```
test/
├── models/                    # Unit tests for data models
│   ├── note_test.dart
│   └── todo_list_item_test.dart
├── helpers/                   # Unit tests for helper utilities
│   ├── file_helper_test.dart
│   ├── file_type_analyzer_test.dart
│   └── app_helpers_test.dart
├── services/                  # Unit tests for services
│   └── judge0_service_test.dart
├── controllers/               # Unit tests for GetX controllers
│   └── todo_controller_test.dart
├── widgets/                   # Widget tests for custom widgets
│   └── note_tile_test.dart
├── integration/               # Integration tests for app workflows
│   └── app_integration_test.dart
├── widget_test.dart          # Main app widget test
└── README.md                 # This file
```

## Running Tests

### Run all tests
```bash
flutter test
```

### Run tests in a specific directory
```bash
# Run all model tests
flutter test test/models/

# Run all helper tests
flutter test test/helpers/

# Run all widget tests
flutter test test/widgets/
```

### Run a specific test file
```bash
flutter test test/models/note_test.dart
```

### Run tests with coverage
```bash
flutter test --coverage
```

To view coverage results, you can use `lcov` or `genhtml`:
```bash
# Install lcov (on Ubuntu/Debian)
sudo apt-get install lcov

# Generate HTML report
genhtml coverage/lcov.info -o coverage/html

# Open in browser
open coverage/html/index.html
```

## Test Categories

### Unit Tests

Unit tests verify individual components in isolation:

- **Models Tests**: Verify data model creation, modification, and validation
- **Helpers Tests**: Test utility functions and helper methods
- **Services Tests**: Test service layer logic and API interactions
- **Controllers Tests**: Verify controller state management and business logic

### Widget Tests

Widget tests verify UI components:

- **NoteTile Tests**: Verify note display, interaction, and rendering
- **Other Widgets**: Tests for ContentEditor, MarkdownView, TagEditor (to be added)

### Integration Tests

Integration tests verify complete workflows:

- **App Navigation**: Test navigation between screens
- **Theme Management**: Verify theme switching and persistence
- **Data Persistence**: Test Hive database operations

## Test Coverage

The test suite covers:

✅ **Models**
- Note model creation and modification
- TodoListItem (ChecklistItem and MarkdownItem) functionality

✅ **Helpers**
- File name and extension handling
- File type classification
- Date formatting and utilities

✅ **Controllers**
- Todo list management (add, remove, toggle, reorder)
- Markdown parsing and conversion

✅ **Widgets**
- NoteTile rendering and interaction
- Tag display and file extension badges

✅ **Services**
- Judge0Service code execution structure

✅ **Integration**
- App initialization and navigation
- Theme support
- Data persistence

## Adding New Tests

When adding new features, follow these guidelines:

### 1. Unit Tests
Create unit tests for new models, helpers, or services:
```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('YourComponent Tests', () {
    test('should do something', () {
      // Arrange
      // Act
      // Assert
    });
  });
}
```

### 2. Widget Tests
Create widget tests for new UI components:
```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('YourWidget should display correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: YourWidget()));
    expect(find.text('Expected Text'), findsOneWidget);
  });
}
```

### 3. Integration Tests
Add integration tests for new workflows:
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  setUpAll(() async {
    await Hive.initFlutter();
    // Setup code
  });
  
  testWidgets('Complete workflow test', (WidgetTester tester) async {
    // Test complete user workflow
  });
}
```

## Mocking

The test suite uses `mockito` for mocking dependencies. To generate mocks:

```bash
flutter pub run build_runner build
```

Example mock usage:
```dart
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([YourService])
import 'your_test.mocks.dart';

void main() {
  test('with mock', () {
    final mock = MockYourService();
    when(mock.someMethod()).thenReturn('mocked');
    // Use mock in test
  });
}
```

## Continuous Integration

Tests are automatically run in CI/CD pipelines. Ensure all tests pass before merging:

```bash
# Run tests locally before pushing
flutter test

# Check for linting errors
flutter analyze

# Format code
flutter format .
```

## Best Practices

1. **Arrange-Act-Assert**: Structure tests with clear setup, execution, and verification
2. **Single Responsibility**: Each test should verify one thing
3. **Descriptive Names**: Test names should clearly describe what they verify
4. **Independent Tests**: Tests should not depend on each other
5. **Fast Execution**: Keep tests fast by avoiding unnecessary delays
6. **Clean Up**: Always clean up resources in `tearDown` or `tearDownAll`

## Troubleshooting

### Hive Initialization Errors
If you get Hive initialization errors, ensure you're calling:
```dart
TestWidgetsFlutterBinding.ensureInitialized();
await Hive.initFlutter();
```

### Missing Adapters
Register Hive adapters in `setUpAll`:
```dart
if (!Hive.isAdapterRegistered(0)) {
  Hive.registerAdapter(NoteAdapter());
}
```

### Environment Variables
For tests requiring environment variables, use:
```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

dotenv.testLoad(fileInput: 'KEY=value');
```

## Contributing

When contributing tests:

1. Follow the existing test structure
2. Maintain high test coverage (aim for >80%)
3. Write clear, maintainable tests
4. Add tests for bug fixes
5. Update this README if adding new test categories

## Resources

- [Flutter Testing Documentation](https://docs.flutter.dev/testing)
- [Effective Dart: Testing](https://dart.dev/guides/language/effective-dart/usage#testing)
- [Mockito Package](https://pub.dev/packages/mockito)
- [Flutter Test Package](https://pub.dev/packages/flutter_test)
