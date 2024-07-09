// lib/pages/my_story_page.dart
import 'package:flutter/material.dart';

class MyStoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('My Story Page'),
        backgroundColor: Color(0xFFFFA423),
      ),
      body: Center(
        child: Text('This is My Story Page'),
      ),
    );
  }
}