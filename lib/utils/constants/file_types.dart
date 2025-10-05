class FileTypes {
  const FileTypes._();

  static const List<String> markdown = [
    'md',
    'markdown',
  ];

  static const List<String> plainText = [
    'txt',
    'log',
    'rtf',
  ];

  static const List<String> programmingLanguage = [
    // Web
    'html',
    'css',
    'js',
    'ts',
    'json',
    'xml',
    'yaml',
    'yml',

    // Compiled/General
    'c',
    'cpp',
    'h',
    'cs',
    'java',
    'kt',
    'dart',
    'py',
    'go',
    'rb',
    'rs',
    'swift',
    'sh',

    // Data
    'csv',
  ];

  static final List<String> supportedExtensions = [
    ...markdown,
    ...plainText,
    ...programmingLanguage,
  ];
}