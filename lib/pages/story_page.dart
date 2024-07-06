import 'package:flutter/material.dart';

class StoryPage extends StatefulWidget {
  final String title;

  StoryPage({required this.title});

  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        widget.title,
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
      ),
    );
  }
}