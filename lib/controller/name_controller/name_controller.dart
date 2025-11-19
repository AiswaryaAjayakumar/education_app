import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NameController with ChangeNotifier {
  bool loading = false;
  String? message;

  Future<bool> addFullname(String fullname, String token) async {
    loading = true;
    notifyListeners();

    final url = Uri.parse("https://machinetest.flutter.penoft.com/api/user/add-fullname");

    final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
      },
      body: {
        "fullname": fullname,
      },
    );

    loading = false;

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      message = data["message"];
      notifyListeners();

      return true;
    } else {
      message = "Something went wrong";
      notifyListeners();
      return false;
    }
  }
}
