import 'dart:math';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String title;
  final String ID, tier;
  final List<String> most_tag;
  final int today_solve;
  HomePage({required this.title, required this.ID, required this.tier, required this.most_tag, required this.today_solve});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    String most_tag = '#' + widget.most_tag[0] + ', ' + '#' + widget.most_tag[1] + ', ' + '#' + widget.most_tag[2];
    int today_solve = widget.today_solve;
    int aim_solve = 10;
    int remain_solve = max(0, aim_solve - today_solve);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 13,
                itemBuilder: (BuildContext context, int index) {
                  switch (index) {
                    case 0: return Icon(Icons.account_circle, color: Color(0xFFFFF1DE), size: 170);
                    case 1: return Container(padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(color: Color(0xFFFFF1DE), child: Text(widget.ID.toString()),),
                      Text("님의 현재 티어는 ", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                      Container(color: Color(0xFFFFF1DE), child: Text(widget.tier.toString()),),
                      Text("입니다.", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                    ],),);
                    case 2: return Text("$most_tag 고수이시네요.", style: TextStyle(fontSize: 20), textAlign: TextAlign.center);
                    case 3: return SizedBox(height: 20,);
                    case 4: return Text("오늘 $today_solve문제를 풀었으며,", style: TextStyle(fontSize: 20), textAlign: TextAlign.center);
                    case 5: return Text("목표 달성까지 $remain_solve문제 남았습니다.", style: TextStyle(fontSize: 20), textAlign: TextAlign.center);
                    case 6: return SizedBox(height: 5,);
                    case 7: return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            onPressed: () {
                              debugPrint('TextButton pressed');
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                              foregroundColor: Colors.white,
                              backgroundColor: Color(0xFF49454F),
                            ),
                            child: const Text('목표 수정하기'),
                          ),
                        ]
                    );
                    case 8: return SizedBox(height: 20,);
                    case 9: return Text("다른 사람들은 지금...", style: TextStyle(fontSize: 20), textAlign: TextAlign.center);
                    default: return ListTile(
                      leading: Icon(Icons.account_circle, color: Color(0xFFFFF1DE), size: 50),
                      title: Text('azberjibiou'),
                      subtitle: Text('오늘 $index문제 해결'),
                    );
                  }
                },
              ),
              /*
              child: ListView(
                children: [
                  Icon(Icons.account_circle, color: Color(0xFFFFF1DE), size: 170),
                  Text("$ID님의 현재 티어는 $tier입니다.", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                  Text("$most_tag 고수이시네요.", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                  SizedBox(height: 20,),
                  Text("오늘 $today_solve문제를 풀었으며,", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                  Text("목표 달성까지 $remain_solve문제 남았습니다.", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () {
                          debugPrint('TextButton pressed');
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xFF49454F),
                        ),
                        child: const Text('목표 수정하기'),
                      ),
                    ]
                  ),
                ]
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(title: Text('$index'));
                    },
                  ),
                ),
              ]
              */
            ),
          ]
        ),
      )
    );
  }
}