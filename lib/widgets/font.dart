import 'package:flutter/cupertino.dart';

Widget backgroundFont(String text, String font) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 3),
    decoration: BoxDecoration(
      color: Color(0xFFFFF1DE),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Font(text.toString(), font),
  );
}

Widget Font(String text, String font) {
  double size = 0;
  if (font == "L") size = 20;
  else if (font == "M") size = 16;
  else if (font == "S") size = 12;
  return Text(text, style: TextStyle(fontSize: size), textAlign: TextAlign.center);
}