# Product Requirements Document (PRD)

**Product Name:** SwiftWrite (placeholder)  
**Owner:** Ishaan Jindal  
**Platform:** Flutter (cross-platform: Android, iOS, Web, Desktop)

---

## 1. Goal

Build a high-performance writer app focused on **speed, efficiency, and markdown support**, with future extensions for **code snippets** and **advanced writing workflows**.

---

## 2. Core Features (MVP)

- **Fast editor:**
  - Plaintext-first experience using `EditableText`/`TextField`.
  - Low-latency input handling.
- **Markdown support:**
  - Live preview toggle.
  - Basic syntax highlighting (headers, bold, italics, links, lists).
- **Storage:**
  - Local offline storage (Hive).
- **Search:** Fast in-app note search.
- **Tagging:** Organize notes with tags.
- **Themes:** Light and dark mode.

---

## 3. Extended Features (v2)

- **Code snippets:**
  - Syntax highlighting in markdown preview for code blocks enclosed with ```.
  - Automatic syntax highlighting for notes with code-like extensions (e.g., `main.py`, `hello.c`).
  - Support for at least 5–10 languages.
- **Rich blocks (optional, future):** To-do lists, headings, quotes, embedded media.

---

## 4. Non-Goals (MVP)

- Real-time collaboration.
- Heavy WYSIWYG editing.
- Multi-user workspace.
- Cloud sync.

---

## 5. Success Metrics

- Editor input latency < 16ms.
- Markdown rendering < 100ms for 10k+ characters.
- Local search return < 200ms for 1k+ notes.

---

## 6. Technical Notes

- **Editor:** Flutter `EditableText` for raw performance.
- **Markdown Rendering:** `flutter_markdown` or custom renderer for preview.
- **Code Highlighting:** `highlight.dart` for code syntax.
- **Storage:** Hive for MVP.
- **State Management:** GetX.

---

## 7. MVP Development Plan

### Phase 1: Project Setup & Foundation

- **Dependencies:** Install and configure core packages:
  - `get`: For state management and navigation.
  - `hive` & `hive_flutter`: For local database.
  - `path_provider`: To find the correct local path for Hive.
- **Architecture:**
  - Set up the GetX folder structure (`controllers`, `views`, `models`, `bindings`).
  - Create a `Note` model.
  - Implement base routing and navigation.
- **UI Shell:**
  - Build the main app layout (e.g., a home screen with a note list and a floating action button to create a new note).
  - Implement theme switching for light and dark modes.

### Phase 2: Core Editor & Storage

- **Database:**
  - Initialize Hive and register the `Note` adapter.
  - Create a `DatabaseService` to handle all CRUD (Create, Read, Update, Delete) operations.
- **Editor Screen:**
  - Build the note editor view using a `TextField` or `EditableText` widget.
  - Connect the editor to a GetX controller to manage its state (`TextEditingController`).
  - Implement logic to save notes to Hive automatically (debounced) or manually.
- **Note List:**
  - Create a view to display all saved notes from Hive.
  - Allow users to tap a note to open it in the editor.
  - Implement swipe-to-delete functionality.

### Phase 3: Markdown Preview

- **Markdown Preview:**
  - Integrate the `flutter_markdown` package.
  - Add a toggle button on the editor screen to switch between the raw text editor and a read-only markdown preview.

### Phase 4: Search & Organization

- **Tagging:**
  - Add a `List<String> tags` field to the `Note` model.
  - Create UI in the editor to add/remove tags for a note.
  - Update the home screen to allow filtering notes by tag.
- **Search:**
  - Add a search bar to the note list screen.
  - Implement a search controller and logic to filter notes by title and content in real-time.

### Phase 5: Refinement & Performance Tuning

- **Performance:**
  - Profile the editor's input latency.
  - Benchmark markdown rendering and search speeds against the success metrics.
  - Optimize database queries and UI rendering.
- **Polish:**
  - Refine UI/UX based on initial testing.
  - Ensure a smooth and intuitive user flow.
  - Fix any outstanding bugs.

### Phase 6: Code Snippet Highlighting

- **Integration:**
  - Integrate the `highlight.dart` package or a similar syntax highlighting library.
  - Add language detection for code blocks (```) and based on note title extension.
- **UI:**
  - Render highlighted code within the markdown preview.
  - Ensure the code blocks are styled correctly in both light and dark themes.

### Phase 7: Public Release

- **App Store Preparation:**
  - Create app icons and splash screens.
  - Prepare listings for the App Store and Google Play.
- **Deployment:**
  - Build and sign release versions of the app.
  - Publish to the respective app stores.
- **Marketing:**
  - Announce the release on social media and relevant forums.
