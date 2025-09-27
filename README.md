# SwiftWrite

A high-performance, cross-platform writer app built with Flutter, focused on speed, efficiency, and Markdown support.

## Goal

To build a minimalist writer app that prioritizes a fast, distraction-free experience. It's designed for writers, developers, and students who need a reliable tool for capturing notes, drafting content, and organizing ideas with Markdown and (eventually) code snippets.

## Features (In Progress)

- **Fast, distraction-free editor:** A simple, clean interface that lets you focus on writing.
- **Local First Storage:** All notes are stored locally on your device using Hive, ensuring your data is always available, even offline.
- **Theme Support:** Switch between light and dark modes to suit your preference.
- **Note Management:** Create, edit, and delete notes with ease. Notes are saved automatically.
- **Swipe to Delete:** Quickly delete notes from the list with a simple swipe gesture.

### Planned Features

- Markdown live preview
- Tagging and filtering
- Full-text search
- Export to `.md` and `.txt`
- Code snippet support with syntax highlighting

## Tech Stack

- **Framework:** [Flutter](https://flutter.dev/)
- **State Management:** [GetX](https://pub.dev/packages/get)
- **Local Database:** [Hive](https://pub.dev/packages/hive)
