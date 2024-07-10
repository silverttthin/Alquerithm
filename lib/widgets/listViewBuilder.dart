import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget listViewBuilder(List<Widget> todo) {
  return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                itemCount: todo.length,
                itemBuilder: (BuildContext context, int index) {
                  return todo[index];
                },
              ),
            ),
          ],
        ),
      )
  );
}