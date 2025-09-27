import 'package:flutter/material.dart';

class WriterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          maxLines: null,
          expands: true,
          decoration: InputDecoration(
            hintText: 'Start writing...',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
