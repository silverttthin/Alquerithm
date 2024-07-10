import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../main.dart';

class CheckLogin extends StatefulWidget {
  @override
  _CheckLoginState createState() => _CheckLoginState();
}

class _CheckLoginState extends State<CheckLogin> {
  bool _check() {
    return false;
  }

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('jwt_token');

    if (token != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _pwController = TextEditingController();

  Future<void> _login() async {
    // 로딩 다이얼로그 표시
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 16),
                Text("백준 정보를 가져오는 중이에요.."),
              ],
            ),
          ),
        );
      },
    );

    final response = await http.post(
      Uri.parse('http://192.168.227.4:8080/users/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': _idController.text,
        'password': _pwController.text,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final token = responseBody['access_token'];
      print("--------------------------------------------------------------");
      print("token -> $token");
      // SharedPreferences에 토큰 저장
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token);

      // 로딩 다이얼로그 닫기
      Navigator.of(context).pop();

      // 로그인 성공 알림창
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('로그인 성공!', textAlign: TextAlign.center,),
          );
        },
      );

      // 0.8초 뒤에 메인 화면으로 이동
      Future.delayed(Duration(milliseconds: 800), () {
        Navigator.of(context).pop();  // 알림창 닫기
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      });
    } else {
      // 로딩 다이얼로그 닫기
      Navigator.of(context).pop();

      // Handle error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('로그인 실패'),
            content: Text('아이디 또는 비밀번호를 확인하세요.'),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFA423),
      body: Center(
        child: Card(
          color: Colors.white,
          child: Container(
            height: 230,
            width: 400,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: _idController,
                    decoration: InputDecoration(labelText: "id 입력"),
                  ),
                ),
                Expanded(
                  child: TextField(
                    obscureText: true,
                    controller: _pwController,
                    decoration: InputDecoration(labelText: "pw 입력"),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 20,
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          foregroundColor: Color(0xFF49454F),
                          backgroundColor: Colors.white,
                          side: BorderSide(width: 1, color: Color(0xFF49454F)),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()),
                          );
                        },
                        child: Text('회원가입'),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xFF49454F),
                        ),
                        onPressed: _login,
                        child: Text('로그인'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  TextEditingController _bojIdController = TextEditingController();

  Future<void> _register() async {
    // 로딩 다이얼로그 표시
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 16),
                Text("백준 정보를 가져와 저장 중이에요.."),
              ],
            ),
          ),
        );
      },
    );

    final response = await http.post(
      Uri.parse('http://192.168.227.4:8080/users/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': _idController.text,
        'password': _pwController.text,
        'boj_username': _bojIdController.text,
      }),
    );

    if (response.statusCode == 200) {
      // 로딩 다이얼로그 닫기
      Navigator.of(context).pop();

      // 회원가입 성공 알림창
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('회원가입 성공!', textAlign: TextAlign.center,),
          );
        },
      );

      // 0.8초 뒤에 로그인 페이지로 이동
      Future.delayed(Duration(milliseconds: 800), () {
        Navigator.of(context).pop();  // 알림창 닫기
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      });
    } else {
      // 로딩 다이얼로그 닫기
      Navigator.of(context).pop();

      // Handle error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('회원가입 실패'),
            content: Text('입력한 정보를 확인하세요.'),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFA423),
      body: Center(
        child: Card(
          color: Colors.white,
          child: Container(
            height: 280,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: _idController,
                    decoration: InputDecoration(labelText: "id 입력"),
                  ),
                ),
                Expanded(
                  child: TextField(
                    obscureText: true,
                    controller: _pwController,
                    decoration: InputDecoration(labelText: "pw 입력"),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _bojIdController,
                    decoration: InputDecoration(labelText: "BOJ id 입력"),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 20,
                  ),
                ),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      foregroundColor: Color(0xFF49454F),
                      backgroundColor: Colors.white,
                      side: BorderSide(width: 1, color: Color(0xFF49454F)),
                    ),
                    onPressed: _register,
                    child: Text('회원가입'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}