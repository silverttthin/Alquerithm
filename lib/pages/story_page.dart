import 'package:flutter/material.dart';
import 'package:alquerithm/widgets/comment.dart';

class StoryPage extends StatefulWidget {
  final String title;

  StoryPage({required this.title});

  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  bool _isBookmarked = false;
  bool _showAdditionalButtons = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color: Colors.orange,
                    ),
                    onPressed: () {
                      setState(() {
                        _isBookmarked = !_isBookmarked;
                      });
                    },
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () {
                          // 이전 글로 이동하는 로직
                        },
                      ),
                      Text(
                        '\$문제 번호\$ AC', // 문제번호 데이터 들어가야 하는 곳!!!!!!!!!!!!!
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward, color: Colors.black),
                        onPressed: () {
                          // 다음 글로 이동하는 로직
                        },
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.menu, color: Colors.orange),
                    onPressed: () {
                      setState(() {
                        _showAdditionalButtons = !_showAdditionalButtons;
                      });
                    },
                  ),
                ],
              ),
            ),




            // 게시글!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1
            Container(
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFFFA423), width: 2.0),
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
              ),


              child: Row(
                children: [
                  Icon(Icons.person), // 게시자 이미지 디비에서 가져와 크기 변형해 넣어야 함
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Text( // 게시글 내용으로 바인딩해야함
                      '이는 흔히 알려진 방법대로 세그먼트 트리 내지는 펜윅트리로 빠르게 구할 수 있다. '
                      '이런이런 부분에서 구현할 때 주의해줘야된다.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),


            // 댓글창!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1
            Expanded(
              child: ListView(
                children: [
                  CommentCard(
                      text: '그거 펜윅 안쓰고 투포인터로 밀면 O(N^2)에 돌아요',
                      likes: 17,
                      writer: "silverttthin"),
                  CommentCard(
                      text: '비재귀 세그 ㄱㄱ', likes: 2, writer: "silverttthin"),
                  CommentCard(
                      text: '단조성 관찰 증명이 부족하지만 여백이 부족해 여기에 적진 않겠습니다.',
                      likes: 24,
                      writer: "Ferma"),
                ],
              ),
            ),


            // 검색창!!!!!!!!!!!!!!!!!!!!!!!!!
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.orange.shade50,
                    child: Icon(Icons.person, color: Colors.orange),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: '댓글을 입력하세요',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24.0),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  IconButton(
                    icon: Icon(Icons.send, color: Colors.orange),
                    onPressed: () {
                      // 댓글 전송 로직
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        _showAdditionalButtons
            ? Positioned(
                right: 15,
                top: 70,
                child: Column(
                  children: [
                    _buildAdditionalButton(Icons.add, '글 게시'),
                    _buildAdditionalButton(Icons.person, '내 스토리'),
                    // _buildAdditionalButton(Icons.filter_alt, '필터'),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }

  // 우상단 햄버거 버튼
  Widget _buildAdditionalButton(IconData icon, String tooltip) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: FloatingActionButton(
        onPressed: () {
          // 추가 기능 로직
        },
        backgroundColor: Colors.orange,
        child: Icon(icon),
        tooltip: tooltip,
      ),
    );
  }
}
