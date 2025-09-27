import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SwiftWrite'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () {
              // Theme switching logic will go here
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Note list will go here'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/writer'),
        child: Icon(Icons.add),
      ),
    );
  }
}
