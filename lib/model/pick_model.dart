import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PickData {
  late List<int> pickProblems;
  late String leastTag;
  late List<int> leastTagProblems;
  late String mostTag;
  late List<int> mostTagProblems;

  PickData({
    required this.pickProblems,
    required this.leastTag,
    required this.leastTagProblems,
    required this.mostTag,
    required this.mostTagProblems,
  });

  factory PickData.fromJson(Map<String, dynamic> json) {
    return PickData(
      pickProblems: List<int>.from(json['pick_problem']),
      leastTag: json['least_tag'],
      leastTagProblems: List<int>.from(json['least_tag_problem']),
      mostTag: json['most_tag'],
      mostTagProblems: List<int>.from(json['most_tag_problem']),
    );
  }
}

class PickApiService {
  static const String apiUrl = "http://192.168.227.4:8080"; // API URL을 설정합니다.

  Future<PickData> fetchPickData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('jwt_token');

    print("제발 token : $token");
    final response = await http.get(
      Uri.parse("$apiUrl/users/picks/"),
      headers: {
        'Authorization': 'Bearer $token', // 필요한 경우 토큰을 추가합니다.
      },
    );

    if (response.statusCode == 200) {
      return PickData.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load pick data');
    }
  }
}