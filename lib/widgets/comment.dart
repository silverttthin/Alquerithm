// widgets/comment_card.dart
import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  final String text;
  final int likes;
  final String writer;

  const CommentCard({
    required this.text,
    required this.likes,
    required this.writer,
  });

  @override
  Widget build(BuildContext context) {
    bool isPopular = likes >= 10;

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      color: isPopular ? Color(0xFFFFF1DE) : Color(0xFFE3E3E3),
      child: ListTile(
        leading: Icon(Icons.person),
        title: Text(text),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.thumb_up,
              color: isPopular ? Color(0xFFFFA423) : Colors.grey,
            ),
            SizedBox(height: 4.0),
            Text(
              likes.toString(),
              style: TextStyle(
                color: isPopular ? Color(0xFFFFA423) : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}