# Contributing to SwiftWrite

First off, thank you for considering contributing to SwiftWrite! It's great to have you here. As a solo developer, I appreciate any help I can get. This document will provide a brief overview of the project and guide you on how to contribute.

## Project Overview

SwiftWrite is a simple, fast, and elegant note-taking application built with Flutter. The goal is to provide a clean and distraction-free writing experience.

### Tech Stack

- **Framework:** [Flutter](https://flutter.dev/)
- **State Management:** [GetX](https://pub.dev/packages/get)
- **Local Storage:** [Hive](https://pub.dev/packages/hive)
- **UI:** Material Design with a custom theme.

### Project Structure

The project follows a feature-driven architecture. Here's a quick rundown of the key directories under `lib/`:

-   `api/`: Contains services for interacting with external APIs (like the planned Judge0 integration).
-   `controllers/`: Holds the GetX controllers that manage the application's state and business logic.
-   `data/`: Includes data models (`models/`) and services for data persistence (`services/`).
-   `utils/`: A place for shared constants, helper functions, themes, and custom widgets.
-   `views/`: Contains the UI screens of the application.

## Getting Started

1.  **Fork & Clone:** Fork the repository and clone it to your local machine.
2.  **Install Dependencies:** Run `flutter pub get` in the root directory.
3.  **Run Code Generation:** The project uses Hive, which requires code generation. Run the following command to generate the necessary files:
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```
4.  **Run the App:** Use `flutter run` to start the application on your preferred device or emulator.

## How to Contribute

Since this is a small project, the contribution process is straightforward.

1.  **Open an Issue:** Before starting any work, please open an issue to discuss the feature, bug, or improvement you have in mind. This helps to ensure that your work aligns with the project's goals.
2.  **Create a Branch:** Create a new branch from `main` for your changes. A good branch name would be `feat/your-feature-name` or `fix/your-bug-fix`.
3.  **Write Code:** Make your changes, following the existing code style and conventions.
4.  **Submit a Pull Request:** Once you're ready, submit a pull request to the `main` branch. Please provide a clear description of the changes you've made.

## Coding Style & Conventions

-   **Linting:** The project uses `flutter_lints`. Please ensure your code adheres to these rules.
-   **File Naming:** Use `snake_case` for file names (e.g., `writer_screen.dart`).
-   **Structure:** Please follow the existing directory structure. For example, new UI screens go in `views/`, and their corresponding state management logic goes in `controllers/`.
-   **Commit Messages:** Write clear and concise commit messages that explain the "why" behind your changes.

## Testing Guidelines

We have a comprehensive test suite to ensure code quality. Please follow these guidelines:

### Writing Tests

1.  **Add Tests for New Features:** All new features should include appropriate tests
2.  **Fix Broken Tests:** If your changes break existing tests, update them accordingly
3.  **Test Coverage:** Aim to maintain or improve test coverage with your changes
4.  **Test Structure:** Follow the existing test structure in the `test/` directory:
    -   Unit tests in `test/models/`, `test/helpers/`, `test/services/`, `test/controllers/`
    -   Widget tests in `test/widgets/`
    -   Integration tests in `test/integration/`

### Running Tests

Before submitting a pull request, ensure all tests pass:

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/models/note_test.dart

# Run tests with coverage
flutter test --coverage

# Use the provided test script
./scripts/run_tests.sh
```

### Test Requirements

-   All tests must pass before merging
-   New features should include unit tests and/or widget tests
-   Bug fixes should include a test that reproduces the bug
-   Maintain test coverage above 80% when possible

For more detailed testing information, see [test/README.md](test/README.md).

## Code Quality Checklist

Before submitting your pull request, ensure:

-   [ ] All tests pass (`flutter test`)
-   [ ] Code follows Flutter linting rules (`flutter analyze`)
-   [ ] Code is properly formatted (`dart format .`)
-   [ ] New features include tests
-   [ ] Documentation is updated if needed
-   [ ] Commit messages are clear and descriptive

Thank you again for your interest in contributing!
