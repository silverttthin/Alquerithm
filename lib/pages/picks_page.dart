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
    List<Widget> todo = [
      Row(children: [SizedBox(width: 5), Font("오늘의 추천 문제예요", 'L')]),
      problemCard(pickProblem[0]),
      problemCard(pickProblem[1]),
      problemCard(pickProblem[2]),
      SizedBox(height: 20,),
      Row(children: [SizedBox(width: 5), backgroundFont('#' + leastTag, 'M'), Font(" 공부는 어떤가요?", 'L')]),
      problemCard(leastTagProblem[0]),
      problemCard(leastTagProblem[1]),
      problemCard(leastTagProblem[2]),
      SizedBox(height: 20,),
      Row(children: [SizedBox(width: 5), Font("도전적인 ", 'L'), backgroundFont('#' + mostTag, 'M'), Font(" 문제예요", 'L')]),
      problemCard(mostTagProblem[0]),
      problemCard(mostTagProblem[1]),
      problemCard(mostTagProblem[2]),
    ];
    return listViewBuilder(todo);
  }
}