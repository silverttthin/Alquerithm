import 'package:flutter/material.dart';

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
    bool isLoggedIn = await _check();

    if (isLoggedIn) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => login_page()),
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

class login_page extends StatefulWidget {
  const login_page({super.key});

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFA423),
      body: Center(
        child: Card(
          color: Colors.white,
          child: Container(
            height: 230,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _idController,
                  decoration: InputDecoration(labelText: "id 입력"),
                ),
                TextField(
                  obscureText: true,
                  controller: _pwController,
                  decoration: InputDecoration(labelText: "pw 입력"),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        foregroundColor: Color(0xFF49454F),
                        backgroundColor: Colors.white,
                        side: BorderSide(width: 1, color: Color(0xFF49454F)),
                      ),
                      onPressed: () async {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => registerPage()),
                        );
                      },
                      child: Text('회원가입'),
                    ),
                    SizedBox(width: 20,),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFF49454F),
                      ),
                      onPressed: () async {
                        String pw = '1234';
                        if (pw == _pwController.text) {
                          print(Text('login'));
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => MyHomePage()),
                          );
                        }
                      },
                      child: Text('로그인'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}

class registerPage extends StatefulWidget {
  const registerPage({super.key});

  @override
  State<registerPage> createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  TextEditingController _bojIdController = TextEditingController();

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
                  TextField(
                    controller: _idController,
                    decoration: InputDecoration(labelText: "id 입력"),
                  ),
                  TextField(
                    obscureText: true,
                    controller: _pwController,
                    decoration: InputDecoration(labelText: "pw 입력"),
                  ),
                  TextField(
                    controller: _bojIdController,
                    decoration: InputDecoration(labelText: "BOJ id 입력"),
                  ),
                  SizedBox(height: 20,),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      foregroundColor: Color(0xFF49454F),
                      backgroundColor: Colors.white,
                      side: BorderSide(width: 1, color: Color(0xFF49454F)),
                    ),
                    onPressed: () async {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => MyHomePage()),
                      );
                    },
                    child: Text('회원가입'),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
