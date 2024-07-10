import 'dart:math';

import 'package:flutter/material.dart';
import '../widgets/font.dart';
import '../widgets/listViewBuilder.dart';
import '../widgets/problemCard.dart';

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
    List<int> mostTagProblem, leastTagProblem;

    mostTag = "graph"; leastTag = "geometric";
    pickProblem = [1000, 1001, 1002];
    mostTagProblem = [1000, 1001, 1002];
    leastTagProblem = [1000, 1001, 1002];

    double _runSpace = 5;
    double _contentsSpace = 30;
    double _lineSpace = 10;
    List<Widget> todo = [];

    todo.add(SizedBox(height: _lineSpace,));

    todo.add(Wrap(alignment: WrapAlignment.start, runSpacing: _runSpace, children: [SizedBox(width: 5), Font("오늘의 추천 문제예요", 'XL', bold: true)]),);
    todo.add(SizedBox(height: _lineSpace,));
    for (int i = 0; i < min(3, pickProblem.length); i++) {
      todo.add(problemCard(pickProblem[i]));
      todo.add(SizedBox(height: _runSpace,));
    }
    todo.add(SizedBox(height: _contentsSpace,));

    todo.add(Wrap(alignment: WrapAlignment.start, runSpacing: _runSpace, children: [SizedBox(width: 5), backgroundFont('#' + leastTag, 'XL'), Font(" 공부는 어떤가요?", 'XL', bold: true)]),);
    todo.add(SizedBox(height: _lineSpace,));
    for (int i = 0; i < min(3, leastTagProblem.length); i++) {
      todo.add(problemCard(leastTagProblem[i]));
      todo.add(SizedBox(height: _runSpace,));
    }
    todo.add(SizedBox(height: _contentsSpace,));

    todo.add(Wrap(alignment: WrapAlignment.start, runSpacing: _runSpace, children: [SizedBox(width: 5), Font("도전적인 ", 'XL', bold: true), backgroundFont('#' + mostTag, 'XL'), Font(" 문제예요", 'XL', bold: true)]),);
    todo.add(SizedBox(height: _lineSpace,));
    for (int i = 0; i < min(3, mostTagProblem.length); i++) {
      todo.add(problemCard(mostTagProblem[i]));
      todo.add(SizedBox(height: _runSpace,));
    }

    todo.add(SizedBox(height: _lineSpace,));

    return listViewBuilder(todo);
  }
}