import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/font.dart';
import '../widgets/listViewBuilder.dart';

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
  int _aim_solve = 1;

  Future<void> _showNumberInputDialog() async {
    int? enteredNumber;
    await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController _textController = TextEditingController();
        return AlertDialog(
          backgroundColor: Color(0xFFFFFFFF),
          title: Font("하루에 몇 문제를 푸는 것이 목표인가요?", 'L'),
          content: TextField(
            controller: _textController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: '목표 개수를 입력해주세요.'),
          ),
          actions: <Widget>[
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                side: BorderSide(width: 1, color: Color(0xFF49454F)),
              ),
              child: Font('취소', 'M'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFF49454F),
              ),
              child: Font('확인', 'M'),
              onPressed: () {
                setState(() {
                  enteredNumber = int.tryParse(_textController.text);
                  if (enteredNumber != null) {
                    _aim_solve = enteredNumber!;
                  }
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int today_solve = widget.today_solve;
    int remain_solve = max(0, _aim_solve - today_solve);
    List<Widget> todo = [];
    todo.add(Icon(Icons.account_circle, color: Color(0xFFFFF1DE), size: 170));
    todo.add(
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        backgroundFont(widget.ID, 'M'),
        Font("님의 현재 티어는 ", 'L'),
        backgroundFont(widget.tier, 'M'),
        Font("입니다.", 'L'),
      ],),
    );
    List<Widget> temp = [];
    for (int i = 0; i < 3; i++) {
      if (i > 0) temp.add(Font(', ', 'L'));
      temp.add(backgroundFont('#' + widget.most_tag[i], 'M'));
    }
    todo.add(
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        for (int i = 0; i < temp.length; i++) temp[i],
        Font(" 고수네요.", 'L'),
      ],),
    );
    todo.add(SizedBox(height: 25,));
    todo.add(
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Font("오늘 ", 'L'), backgroundFont(today_solve.toString(), 'M'), Font("문제를 풀었으며,", 'L')
        ],)
    );
    if (remain_solve <= 0) {
      todo.add(Font('오늘 목표를 달성하셨습니다!', 'L'));
    } else {
      todo.add(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Font("목표 달성까지 ", 'L'),
        backgroundFont(remain_solve.toString(), 'M'),
        Font("문제 남았습니다.", 'L')
      ]));
    }
    todo.add(SizedBox(height: 5,));
    todo.add(Container(alignment: Alignment.center, child: TextButton(
      onPressed: () {
        _showNumberInputDialog();
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF49454F),
      ),
      child: const Text('목표 수정하기'),
    )));
    todo.add(SizedBox(height: 25,));
    todo.add(Font("다른 사람들은 지금...", 'L'));
    todo.add(SizedBox(height: 5,));
    List<Color> rankColor = [Color(0xFFF1C16C), Color(0xFFB7C1CB), Color(0xFFCD9A6B)];
    List<String> rank = ['1st', '2nd', '3rd'];
    List<String> ranking = ['azberjibiou', 'songc', 'ho94949'];
    ranking = [];
    List<int> rankingNum = [10, 6, 5];
    for (int i = 0; i < min(ranking.length, 3); i++) {
      todo.add(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          child: Card(
            color: rankColor[i],
            child: ListTile(
              leading: Icon(Icons.account_circle, color: Color(0xFFFFF1DE), size: 50),
              title: Font(ranking[i], 'M'),
              subtitle: Font('오늘 ${rankingNum[i]}문제 해결', 'S'),
              trailing: Font(rank[i], 'M'),
            ),
          ),
        )
      );
    }
    if (ranking.length == 0) {
      todo.add(
          Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
            child: Card(
              color: Color(0xFFE3E3E3),
              child: ListTile(
                title: Font('아직 아무도 문제를 풀지 않았어요.', 'M'),
                subtitle: Font('지금 문제 풀면 1등!', 'M'),
              ),
            ),
          )
      );
    }
    return listViewBuilder(todo);
  }
}