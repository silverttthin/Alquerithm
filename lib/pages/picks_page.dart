import 'dart:math';

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

    double _runSpace = 5;
    double _contentsSpace = 30;
    double _lineSpace = 10;
    List<Widget> todo = [];

    todo.add(SizedBox(height: _lineSpace,));

    todo.add(Wrap(alignment: WrapAlignment.start, runSpacing: _runSpace, children: [SizedBox(width: 5), Font("오늘의 추천 문제예요", 'XL', bold: true)]),);
    todo.add(SizedBox(height: _lineSpace,));
    for (int i = 0; i < min(3, _pickProblems.length); i++) {
      todo.add(problemCard(_pickProblems[i], 'abc', 1234, 14));
      todo.add(SizedBox(height: _runSpace,));
    }
    todo.add(SizedBox(height: _contentsSpace,));

    todo.add(Wrap(alignment: WrapAlignment.start, runSpacing: _runSpace, children: [SizedBox(width: 5), backgroundFont('#' + _leastTag, 'XL'), Font(" 공부는 어떤가요?", 'XL', bold: true)]),);
    todo.add(SizedBox(height: _lineSpace,));
    for (int i = 0; i < min(3, _leastTagProblems.length); i++) {
      todo.add(problemCard(_leastTagProblems[i], 'abc', 1234, 14));
      todo.add(SizedBox(height: _runSpace,));
    }
    todo.add(SizedBox(height: _contentsSpace,));

    todo.add(Wrap(alignment: WrapAlignment.start, runSpacing: _runSpace, children: [SizedBox(width: 5), Font("도전적인 ", 'XL', bold: true), backgroundFont('#' + _mostTag, 'XL'), Font(" 문제예요", 'XL', bold: true)]),);
    todo.add(SizedBox(height: _lineSpace,));
    for (int i = 0; i < min(3, _mostTagProblems.length); i++) {
      todo.add(problemCard(_mostTagProblems[i], 'abc', 1234, 14));
      todo.add(SizedBox(height: _runSpace,));
    }

    todo.add(SizedBox(height: _lineSpace,));

    return listViewBuilder(todo);
  }
}