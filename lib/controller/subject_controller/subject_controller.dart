import 'dart:convert';
import 'package:education_app/model/subject_model/subject_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SubjectController extends ChangeNotifier {
  bool isLoading = false;
  List<SubjectModel> subjects = [];

  Future<void> fetchSubjects(String token) async {
    isLoading = true;
    notifyListeners();

    const url = "https://machinetest.flutter.penoft.com/api/data/subjects";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        subjects = (jsonData["data"] as List)
            .map((e) => SubjectModel.fromJson(e))
            .toList();
      } else {
        print("Server Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Fetch Subjects Error: $e");
    }

    isLoading = false;
    notifyListeners();
  }
}
