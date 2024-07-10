import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _problemNumberController = TextEditingController();
  final _codeLinkController = TextEditingController();
  final _contentController = TextEditingController();

  String _selectedStatus = 'AC';
  final List<String> _statuses = ['AC', 'WA', 'TLE', 'MLE', 'RE', 'CE', '질문'];

  @override
  void dispose() {
    _problemNumberController.dispose();
    _codeLinkController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _showValidationError(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('입력 오류'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }

  // 게시글 제출 전 validation
  void _storySubmit() {
    if (_problemNumberController.text.isEmpty) {
      _showValidationError('문제 번호를 입력하세요.');
      return;
    }

    if (int.tryParse(_problemNumberController.text) == null) {
      _showValidationError('문제 번호는 숫자여야합니다.');
      return;
    }
    if (_codeLinkController.text.isEmpty) {
      _showValidationError('코드 링크를 입력하세요.');
      return;
    }
    if (_contentController.text.isEmpty) {
      _showValidationError('내용을 입력하세요.');
      return;
    }

    // 입력된 값들을 JSON으로 변환
    Map<String, dynamic> postData = {
      'problemNum': _problemNumberController.text,
      'result': _selectedStatus,
      'codeURL': _codeLinkController.text,
      'content': _contentController.text,
    };

    // JSON 데이터 확인
    print("-------------------------------------------------------------");
    print(json.encode(postData));

    // 여기에 서버로 데이터를 전송하는 로직 추가 가능

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('게시 완료!'),
        );
      },
    );

    Future.delayed(Duration(milliseconds: 850), () {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          '/<Alquerithm>',
          style: TextStyle(
            color: Color(0xFFFFA423),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Container(
            color: Color(0xFFFFA423),
            height: 2.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // 문제 번호 입력란
                Expanded(
                  child: TextField(
                    controller: _problemNumberController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      hintText: '문제 번호 입력',
                    ),
                  ),
                ),
                SizedBox(width: 6),
                // 게시글 유형 드롭다운
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF49454F)),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedStatus,
                      icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                      items: _statuses.map((String status) {
                        return DropdownMenuItem<String>(
                          value: status,
                          child: Text(status),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedStatus = newValue!;
                        });
                      },
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      dropdownColor: Colors.white,
                      isDense: true,
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            // 코드 링크 입력란
            TextField(
              controller: _codeLinkController,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                hintText: '코드 링크 입력',
              ),
            ),
            SizedBox(height: 16.0),
            // 게시글 내용
            Expanded(
              child: TextField(
                controller: _contentController,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '내용을 입력하세요',
                ),
              ),
            ),
            SizedBox(height: 16.0),
            // 취소 및 게시하기 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    '취소',
                    style: TextStyle(color: Color(0xFF49454F)),
                  ),
                ),
                ElevatedButton(
                  onPressed: _storySubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF49454F),
                  ),
                  child: Text(
                    '게시하기',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}