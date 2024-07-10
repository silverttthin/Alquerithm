import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/font.dart';
import '../widgets/listViewBuilder.dart';
import '../widgets/toast.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String _boj_username;
  late int _tier;
  late List<String> _user_tags;
  late int _alias_num;
  late int _today_solved;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchHomeData();
  }

  Future<void> _fetchHomeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('jwt_token');

    final response = await http.get(
      Uri.parse('http://192.168.227.4:8080/users/home'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes));
      setState(() {
        _boj_username = data['boj_username'];
        _tier = data['tier'];
        _user_tags = List<String>.from(data['user_tags']);
        _alias_num = data['alias_num'];
        _today_solved = data['today_solved'];
        _isLoading = false;
      });
    } else {
      print('Failed to load home data');
    }
  }

  String tierIntToStr(int tier) {
    List<String> _tierFirstChar = ['Bronze', 'Silver', 'Gold', 'Platinum', 'Diamond', 'Ruby'];
    tier -= 1;
    return _tierFirstChar[tier ~/ 5] + (5 - tier % 5).toString();
  }

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
                foregroundColor: Color(0xFF49454F),
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
                    _alias_num = enteredNumber!;
                    showToast('일일 목표를 $enteredNumber문제로 변경했습니다.');
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

  Widget buildInfoBox(String text) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8), // 간격 조정
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text(''),
          centerTitle: true,
          elevation: 0,
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    int remainSolve = max(0, _alias_num - _today_solved);
    List<Widget> todo = [];
    todo.add(Icon(Icons.account_circle, color: Color(0xFFFFF1DE), size: 170));
    todo.add(
      Wrap(
        alignment: WrapAlignment.center,
        children: [
          buildInfoBox("$_boj_username님의 현재 티어는 ${tierIntToStr(_tier)}입니다."),
        ],
      ),
    );
    List<Widget> temp = [];
    for (int i = 0; i < min(3, _user_tags.length); i++) {
      temp.add(buildInfoBox('#' + _user_tags[i]));
    }
    todo.add(
      Wrap(
        alignment: WrapAlignment.center,
        children: [
          for (int i = 0; i < temp.length; i++) temp[i],
          buildInfoBox(" 고수네요."),
        ],
      ),
    );
    todo.add(SizedBox(height: 25));
    todo.add(
      Wrap(
        alignment: WrapAlignment.center,
        children: [
          buildInfoBox("오늘 $_today_solved 문제를 풀었으며,")
        ],
      ),
    );
    if (remainSolve <= 0) {
      todo.add(buildInfoBox('오늘 목표를 달성하셨습니다!'));
    } else {
      todo.add(Wrap(
        alignment: WrapAlignment.center,
        children: [
          buildInfoBox("목표 달성까지 $remainSolve 문제 남았습니다."),
        ],
      ));
    }
    todo.add(SizedBox(height: 5));
    todo.add(Container(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {
          _showNumberInputDialog();
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          foregroundColor: Colors.white,
          backgroundColor: Color(0xFF49454F),
        ),
        child: const Text('목표 수정하기'),
      ),
    ));
    todo.add(SizedBox(height: 25));
    todo.add(Font("다른 사람들은 지금...", 'L'));
    todo.add(SizedBox(height: 5));
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
        ),
      );
    }
    if (ranking.isEmpty) {
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
        ),
      );
    }
    return listViewBuilder(todo);
  }
}