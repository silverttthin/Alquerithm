import 'dart:math';
import 'package:alquerithm/pages/picks_page.dart';
import 'package:flutter/cupertino.dart';
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
  int _aim_solve = 1;

  Future<void> _showNumberInputDialog() async {
    int? enteredNumber;
    await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController _textController = TextEditingController();
        return AlertDialog(
          title: Font("하루에 몇 문제를 푸는 것이 목표인가요?", 'M'),
          content: TextField(
            controller: _textController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'Enter number here'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
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
    todo.add(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Font("목표 달성까지 ", 'L'), backgroundFont(remain_solve.toString(), 'M'), Font("문제 남았습니다.", 'L')
    ]));
    todo.add(SizedBox(height: 5,));
    todo.add(Container(alignment: Alignment.center, child: TextButton(
      onPressed: () {
        _showNumberInputDialog();
        // _aimDialog(context);
        // debugPrint('TextButton pressed');
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
    //List<Color> rankColor = [Color(0xFFF4D6A0), Color(0xFFB7C1CB), Color(0xFFDDBEA1)];
    List<Color> rankColor = [Color(0xFFF1C16C), Color(0xFFB7C1CB), Color(0xFFCD9A6B)];
    //List<Color> rankColor = [Color(0xFFEEAD35), Color(0xFF6A8095), Color(0xFFBE7936)];
    List<String> rank = ['1st', '2nd', '3rd'];
    for (int i = 0; i < 3; i++) {
      todo.add(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          child: Card(
            color: rankColor[i],
            child: ListTile(
              leading: Icon(Icons.account_circle, color: Color(0xFFFFF1DE), size: 50),
              title: Text('azberjibiou'),
              subtitle: Text('오늘 10문제 해결'),
              trailing: Font(rank[i], 'M'),
            ),
          ),
        )
      );
    }
    return listViewBuilder(todo);
  }
}

// Widget _aimButton(BuildContext context) {
//   int _number = 0;
//
//
//
//
// }

// Future<dynamic> _aimDialog(BuildContext context) async {
//   int? enteredNumber;
//
//   return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         final TextEditingController _textController = TextEditingController();
//         return AlertDialog(
//           title: Font("하루에 몇 문제를 푸는 것이 목표인가요?"),
//           content: TextField(
//             controller: _textController,
//             keyboardType: TextInputType.number,
//             decoration: InputDecoration(hintText: 'Enter number here'),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text('CANCEL'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text('OK'),
//               onPressed: () {
//                 setState(() {
//                   enteredNumber = int.tryParse(_textController.text);
//                   if (enteredNumber != null) {
//                     _number = enteredNumber!;
//                   }
//                 });
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       }
//   );
// }

