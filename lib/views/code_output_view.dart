import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:writer/utils/widgets/markdown_view.dart';

class CodeOutputView extends StatelessWidget {
  const CodeOutputView({super.key});

  String _decodeBase64(String? data) {
    if (data == null || data.isEmpty) {
      return "";
    }
    try {
      return utf8.decode(base64.decode(data));
    } catch (e) {
      return "Error decoding output: $data";
    }
  }

  String _buildOutputData(Map<String, dynamic> result) {
    final int statusId = result['status']['id'];
    final String statusDescription = result['status']['description'];

    if (statusId == 3) { // Accepted
      String stdout = _decodeBase64(result['stdout']);
      return "# Output\n\n```\n${stdout.isNotEmpty ? stdout : 'Execution finished with no output.'}```";
    } else if (statusId == 6) { // Compilation Error
      String compileOutput = _decodeBase64(result['compile_output']);
      return "# Compilation Error\n\n```\n${compileOutput.isNotEmpty ? compileOutput : 'Compilation failed with no specific error message.'}```";
    } else { // Other errors
      String stderr = _decodeBase64(result['stderr']);
      return "# Error: $statusDescription\n\n```\n${stderr.isNotEmpty ? stderr : 'An error occurred, but no details were provided.'}```";
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>;
    final String code = arguments['code'];
    final Map<String, dynamic> result = arguments['result'];
    final String language = arguments['language'];

    final String outputData = _buildOutputData(result);

    final String data = "# Code\n\n```$language\n$code\n```\n\n$outputData";

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
