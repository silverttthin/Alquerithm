import 'package:flutter/material.dart';

import '../main.dart';

class CheckLogin extends StatefulWidget {
  @override
  _CheckLoginState createState() => _CheckLoginState();
}

class _CheckLoginState extends State<CheckLogin> {
  bool _isLoggedIn = false;

  bool _check() {
    return true;
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

/*
class checkLogin extends StatefulWidget {
  const checkLogin({super.key});

  @override
  State<checkLogin> createState() => _checkLoginState();
}

class _checkLoginState extends State<checkLogin> {
  bool login = true;
  @override
  Widget build(BuildContext context) {
    if (login == false) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => login_page()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    }
    return Text("Hello");
  }
}
 */

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
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 20),
              TextField(
                controller: _idController,
                decoration: InputDecoration(labelText: "id 입력"),
              ),
              TextField(
                obscureText: true,
                controller: _pwController,
                decoration: InputDecoration(labelText: "pw 입력"),
              ),
              ElevatedButton(
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
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => registerPage()),
                  );
                },
                child: Text('회원가입'),
              ),
            ],
          ),
        ),
      ),
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
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 20),
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
              ElevatedButton(
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
    );
  }
}
