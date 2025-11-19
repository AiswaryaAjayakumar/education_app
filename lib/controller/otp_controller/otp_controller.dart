import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OtpController with ChangeNotifier {
  bool isLoading = false;

  // 1️⃣ SEND OTP

  Future<bool> sendOtp(String email) async {
    try {
      isLoading = true;
      notifyListeners();

      final url = Uri.parse(
          "https://machinetest.flutter.penoft.com/api/user/send-otp");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email}),
      );

      isLoading = false;
      notifyListeners();

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // 2️⃣ VERIFY OTP

  Future<Map<String, dynamic>?> verifyOtp(String email, String otp) async {
    try {
      isLoading = true;
      notifyListeners();

      final url = Uri.parse(
          "https://machinetest.flutter.penoft.com/api/user/verify-otp");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "otp": otp}),
      );

      isLoading = false;
      notifyListeners();

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return null;
    }
  }
}
