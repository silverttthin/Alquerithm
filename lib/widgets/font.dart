import 'package:flutter/cupertino.dart';

Widget backgroundFont(String text, String font) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF1DE),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Font(text, font, bold: true),
  );
}

Widget Font(String text, String font, {bool bold = false}) {
  double size = 0;
  var weight = bold ? FontWeight.bold : FontWeight.normal;
  if (font == "XL") size = 24;
  else if (font == "L") size = 20;
  else if (font == "M") size = 16;
  else if (font == "S") size = 12;
  return Text(text, style: TextStyle(fontSize: size, fontWeight: weight), textAlign: TextAlign.center);
}