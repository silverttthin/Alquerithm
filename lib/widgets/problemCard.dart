import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget problemCard(int problemNum) {
  String problemTitle = "A+B";
  int problemSolveNum = 1000000;
  // bool problemSolved = false;
  return Card(
    // color: problemSolved ? Color(0xFFDEFFDE) : Color(0xFFE3E3E3),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(width: 1.5, color: Color(0xFFE3E3E3)),
    ),
    color: Color(0xFFFFFFFF),

    child: ListTile(
      title: Text("$problemNum번: $problemTitle"),
      subtitle: Text("$problemSolveNum명이 풀었어요"),
      trailing:  Image.asset('assets/img/11.png'),
    ),
  );
}