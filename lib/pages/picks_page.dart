import 'package:flutter/material.dart';

class PicksPage extends StatefulWidget {
  final String title;

  PicksPage({required this.title});

  @override
  _PicksPageState createState() => _PicksPageState();
}

class _PicksPageState extends State<PicksPage> {
  @override
  Widget build(BuildContext context) {
    String mostTag, leastTag;
    List<int> pickProblem;
    int mostTagProblem, leastTagProblem;

    mostTag = "graph"; leastTag = "geometric";
    pickProblem = [1000, 1001, 1002]; mostTagProblem = 5000; leastTagProblem = 100000;
    List<Widget> todo = [
      Row(children: [SizedBox(width: 5), Font("오늘의 추천 문제예요", 'L')]),
      _problemCard(pickProblem[0]),
      _problemCard(pickProblem[1]),
      _problemCard(pickProblem[2]),
      SizedBox(height: 20,),
      Row(children: [SizedBox(width: 5), backgroundFont('#' + leastTag, 'M'), Font(" 공부는 어떤가요?", 'L')]),
      _problemCard(leastTagProblem),
      SizedBox(height: 20,),
      Row(children: [SizedBox(width: 5), Font("도전적인 ", 'L'), backgroundFont('#' + mostTag, 'M'), Font(" 문제예요", 'L')]),
      _problemCard(mostTagProblem),
    ];
    return listViewBuilder(todo);
  }
}

Widget _problemCard(int problemNum) {
  String problemTitle = "A+B";
  int problemSolveNum = 1000000;
  bool problemSolved = true;
  return Card(
    color: problemSolved ? Color(0xFFDEFFDE) : Color(0xFFE3E3E3),
    child: ListTile(
      title: Text("$problemNum번: $problemTitle"),
      subtitle: Text("$problemSolveNum명이 풀었어요"),
      trailing: Icon(Icons.turned_in),
    ),
  );
}

Widget backgroundFont(String text, String font) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 3),
    decoration: BoxDecoration(
      color: Color(0xFFFFF1DE),
      borderRadius: BorderRadius.circular(5),
    ),
    // color: Color(0xFFFFF1DE),
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