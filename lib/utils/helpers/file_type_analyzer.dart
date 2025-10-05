import 'package:writer/utils/constants/file_types.dart';

enum FileType {
  markdown,
  plainText,
  programmingLanguage,
  unsupported,
}

class FileTypeAnalyzer {
  const FileTypeAnalyzer._();

  static FileType classifyExtension(String? extension) {
    if (extension == null) {
      return FileType.plainText;
    }

    final ext = extension.toLowerCase();

    if (FileTypes.markdown.contains(ext)) {
      return FileType.markdown;
    }
    if (FileTypes.plainText.contains(ext)) {
      return FileType.plainText;
    }
    if (FileTypes.programmingLanguage.contains(ext)) {
      return FileType.programmingLanguage;
    }

    return FileType.unsupported;
  }
}
