import 'package:flutter/material.dart';
import '../widgets/font.dart';
import '../widgets/listViewBuilder.dart';
import '../widgets/problemCard.dart';
import 'package:alquerithm/model/home_model.dart';
import 'package:alquerithm/model/pick_model.dart'; // PickApiService 및 PickData 가져오기

class PicksPage extends StatefulWidget {
  final String title;

  PicksPage({required this.title});

  @override
  _PicksPageState createState() => _PicksPageState();
}

class _PicksPageState extends State<PicksPage> {
  late List<int> _pickProblems;
  late String _leastTag;
  late List<int> _leastTagProblems;
  late String _mostTag;
  late List<int> _mostTagProblems;

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
        _pickProblems = pickData.pickProblems;
        _leastTag = pickData.leastTag;
        _leastTagProblems = pickData.leastTagProblems;
        _mostTag = pickData.mostTag;
        _mostTagProblems = pickData.mostTagProblems;

        _isLoading = false;

        print('테스트 ${_pickProblems} $_leastTag $_leastTagProblems');
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

    List<Widget> todo = [
      Row(children: [SizedBox(width: 5), Font("오늘의 추천 문제예요", 'L')]),
      problemCard(_pickProblems[0], 'abc', 1234, 14),
      problemCard(_pickProblems[1], 'abc', 1234, 14),
      problemCard(_pickProblems[2], 'abc', 1234, 14),

      SizedBox(height: 20,),
      Row(children: [SizedBox(width: 5), backgroundFont('#' + _leastTag, 'M'), Font(" 공부는 어떤가요?", 'L')]),
      problemCard(_leastTagProblems[0], 'abc', 1234, 14),
      problemCard(_leastTagProblems[1], 'abc', 1234, 14),
      problemCard(_leastTagProblems[2], 'abc', 1234, 14),

      SizedBox(height: 20,),
      Row(children: [SizedBox(width: 5), Font("도전적인 ", 'L'), backgroundFont('#' + _mostTag, 'M'), Font(" 문제예요", 'L')]),
      problemCard(_mostTagProblems[0], 'abc', 1234, 14),
      problemCard(_mostTagProblems[1], 'abc', 1234, 14),
      problemCard(_mostTagProblems[2], 'abc', 1234, 14),
    ];

    return listViewBuilder(todo);
  }
}