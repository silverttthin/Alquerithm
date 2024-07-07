// lib/pages/add_page.dart
import 'package:flutter/material.dart';

class AddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Page'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Text('This is the Add Page'),
      ),
    );
  }
}