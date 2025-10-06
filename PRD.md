# Product Requirements Document (PRD)

**Product Name:** SwiftWrite (placeholder)  
**Owner:** Ishaan Jindal  
**Platform:** Flutter (cross-platform: Android, iOS, Web, Desktop)

---

## 1. Goal

Build a high-performance writer app focused on **speed, efficiency, and markdown support**, with future extensions for **code snippets** and **advanced writing workflows**.

---

## 2. Current Project Status

The core MVP is **complete and functional**. The application currently supports the following features:

-   **Fast Editor:** A responsive and simple writing experience.
-   **Markdown Support:** Live preview toggle for Markdown notes.
-   **Local Storage:** All notes are saved locally using Hive for fast, offline access.
-   **Organization:** Notes can be organized with tags, and the list can be reordered.
-   **Search & Filtering:** Real-time search for note titles/content and filtering by tags.
-   **File Operations:** Notes can be imported from files, saved to files, and shared.
-   **Theming:** Includes both light and dark modes.

---

## 3. Core Features (MVP - Completed)

- **Fast editor:**
  - Plaintext-first experience using `TextField`.
  - Low-latency input handling.
- **Markdown support:**
  - Live preview toggle.
  - Basic syntax highlighting (headers, bold, italics, links, lists, code blocks).
- **Storage:**
  - Local offline storage (Hive).
- **Search:** Fast in-app note search.
- **Tagging:** Organize notes with tags.
- **Themes:** Light and dark mode.

---

## 4. Future Features (v2 and Beyond)

- **Advanced Code Snippet Support:**
  - **In-Progress:** **Judge0 API implementation** to allow for compiling and running code snippets directly within the app.
  - Enhanced syntax highlighting for a wider variety of programming languages.
- **Rich blocks (optional, future):** To-do lists, headings, quotes, embedded media.

---

## 5. Non-Goals

- Real-time collaboration.
- Heavy WYSIWYG editing.
- Multi-user workspace.
- Cloud sync.

---

## 6. Success Metrics

- Editor input latency < 16ms.
- Markdown rendering < 100ms for 10k+ characters.
- Local search return < 200ms for 1k+ notes.

---

## 7. Technical Notes

- **Editor:** Flutter `TextField` for performance and simplicity.
- **Markdown Rendering:** `flutter_markdown_plus` for preview.
- **Code Highlighting:** Handled by the Markdown rendering package.
- **Storage:** Hive.
- **State Management:** GetX.

---

## 8. MVP Development Plan (Completed)

The following plan outlines the steps taken to complete the MVP.

### Phase 1: Project Setup & Foundation

- **Dependencies:** Install and configure core packages:
  - `get`: For state management and navigation.
  - `hive` & `hive_flutter`: For local database.
  - `path_provider`: To find the correct local path for Hive.
- **Architecture:**
  - Set up the GetX folder structure (`controllers`, `views`, `models`).
  - Create a `Note` model.
  - Implement base routing and navigation.
- **UI Shell:**
  - Build the main app layout.
  - Implement theme switching for light and dark modes.

### Phase 2: Core Editor & Storage

- **Database:**
  - Initialize Hive and register the `Note` adapter.
  - Create a `DatabaseService` to handle all CRUD operations.
- **Editor Screen:**
  - Build the note editor view using a `TextField`.
  - Connect the editor to a GetX controller to manage its state.
  - Implement logic to save notes to Hive.
- **Note List:**
  - Create a view to display all saved notes from Hive.
  - Allow users to tap a note to open it in the editor.
  - Implement swipe-to-delete and reordering functionality.

### Phase 3: Markdown Preview

- **Markdown Preview:**
  - Integrate the `flutter_markdown_plus` package.
  - Add a toggle button on the editor screen to switch between the raw text editor and a read-only markdown preview.

### Phase 4: Search & Organization

- **Tagging:**
  - Add a `List<String> tags` field to the `Note` model.
  - Create UI in the editor to add/remove tags for a note.
  - Update the home screen to allow filtering notes by tag.
- **Search:**
  - Add a search bar to the note list screen.
  - Implement a search controller and logic to filter notes in real-time.

### Phase 5: Refinement & Performance Tuning

- **Performance:**
  - Profile and optimize the app.
- **Polish:**
  - Refine UI/UX based on initial testing.
  - Fix any outstanding bugs.

### Phase 6: Code Snippet Highlighting

- **Integration:**
  - Utilized `flutter_markdown_plus` for code block rendering.
- **UI:**
  - Ensured code blocks are styled correctly in both light and dark themes.

### Phase 7: Public Release

- **App Store Preparation:**
  - Create app icons and splash screens.
  - Prepare listings for the App Store and Google Play.
- **Deployment:**
  - Build and sign release versions of the app.
  - Publish to the respective app stores.

