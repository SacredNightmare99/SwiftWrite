import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:writer/utils/widgets/markdown_view.dart';

class CodeOutputView extends StatelessWidget {
  const CodeOutputView({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>;
    final String code = arguments['code'];
    final Map<String, dynamic> result = arguments['result'];
    final String language = arguments['language'];

    final String output = result['stdout'] ?? result['stderr'] ?? result['compile_output'] ?? 'No output';

    final String data = "# Code\n\n```$language\n$code\n```\n\n# Output\n\n```\n$output```";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Code Output'),
      ),
      body: MarkdownView(
        data: data,
      ),
    );
  }
}
