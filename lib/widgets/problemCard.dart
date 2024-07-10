import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget problemCard(int problemNum, String title, int problemSolveNum, int level) {
  int problemSolveNum = 1000000;
  bool problemSolved = (problemNum % 2 == 0);
  return Card(
    color: problemSolved ? Color(0xFFDEFFDE) : Color(0xFFE3E3E3),
    child: ListTile(
      title: Text("$problemNum번: $title"),
      subtitle: Text("$problemSolveNum명이 풀었어요"),
      trailing:  Image.asset('assets/img/$level.png'),
    ),
  );
}