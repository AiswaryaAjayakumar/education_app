import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileController extends ChangeNotifier {
  bool isLoading = false;

  Future<Map<String, dynamic>?> uploadProfilePic(
      String token, File image) async {
    try {
      isLoading = true;
      notifyListeners();

      var request = http.MultipartRequest(
        "POST",
        Uri.parse(
            "https://machinetest.flutter.penoft.com/api/user/add-picture"),
      );

      request.headers["Authorization"] = "Bearer $token";

   
      request.files.add(
        await http.MultipartFile.fromPath("Picture", image.path),
      );

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      print("UPLOAD RESPONSE: $responseBody");

      isLoading = false;
      notifyListeners();

      if (response.statusCode == 200) {
        return jsonDecode(responseBody);
      } else {
        return {"error": "Server error: ${response.statusCode}"};
      }
    } catch (e) {
      print("ERROR: $e");
      isLoading = false;
      notifyListeners();
      return {"error": e.toString()};
    }
  }
}
