import 'package:flutter/material.dart';
import '../widgets/font.dart';
import '../widgets/problemCard.dart';
import 'package:alquerithm/model/home_model.dart';
import 'package:alquerithm/model/pick_model.dart'; // PickApiService 및 PickData 가져오기

class PicksPage extends StatefulWidget {
  @override
  _PicksPageState createState() => _PicksPageState();
}

class _PicksPageState extends State<PicksPage> {
  late List<String> _pick_problems;
  late String _least_tag;
  late List<String> _least_tag_problems;
  late String _most_tag;
  late List<String> _most_tag_problems;

  bool _isLoading = true;

  final PickApiService apiService = PickApiService(); // PickApiService 인스턴스 생성

  @override
  void initState() {
    super.initState();
    _fetchPickData();
  }

  Future<void> _fetchPickData() async {
    try {
      PickData pickData = await apiService.fetchPickData();
      setState(() {
        _pick_problems = pickData.pick_problems;
        _least_tag = pickData.least_tag;
        _least_tag_problems = pickData.least_tag_problems;
        _most_tag = pickData.most_tag;
        _most_tag_problems = pickData.most_tag_problems;

        _isLoading = false;

        print('테스트 ${_pick_problems} $_least_tag $_least_tag_problems');
      });
    } catch (e) {
      print('Failed to load pick data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10),
            Row(children: [SizedBox(width: 5), Font("오늘의 추천 문제예요", 'L')]),
            ..._pick_problems.map((problem) => problemCard(problem, 'abc', 1234, 14)).toList(),
            SizedBox(height: 20),
            Row(children: [SizedBox(width: 5), backgroundFont('#' + _least_tag, 'M'), Font(" 공부는 어떤가요?", 'L')]),
            ..._least_tag_problems.map((problem) => problemCard(problem, 'abc', 1234, 14)).toList(),
            SizedBox(height: 20),
            Row(children: [SizedBox(width: 5), Font("도전적인 ", 'L'), backgroundFont('#' + _most_tag, 'M'), Font(" 문제예요", 'L')]),
            ..._most_tag_problems.map((problem) => problemCard(problem, 'abc', 1234, 14)).toList(),
          ],
        ),
      ),
    );
  }
}