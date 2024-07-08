import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget problemCard(int problemNum) {
  String problemTitle = "A+B";
  int problemSolveNum = 1000000;
  bool problemSolved = (problemNum % 2 == 0);
  return Card(
    color: problemSolved ? Color(0xFFDEFFDE) : Color(0xFFE3E3E3),
    child: ListTile(
      title: Text("$problemNum번: $problemTitle"),
      subtitle: Text("$problemSolveNum명이 풀었어요"),
      trailing:  Image.asset('assets/img/G5.png'),
    ),
  );
}