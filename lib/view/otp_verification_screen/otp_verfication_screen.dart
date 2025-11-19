import 'dart:async';
import 'package:education_app/controller/otp_controller/otp_controller.dart';
import 'package:education_app/view/name_screen/name_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/gradient_button.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;

  const OtpVerificationScreen({super.key, required this.email});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  List<TextEditingController> controllers =
      List.generate(6, (_) => TextEditingController());

  int seconds = 40;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (seconds > 0) {
        setState(() => seconds--);
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    for (var c in controllers) {
      c.dispose();
    }
    super.dispose();
  }

  Widget otpBox(int index) {
    return Container(
      width: 55,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controllers[index],
        textAlign: TextAlign.center,
        maxLength: 1,
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 22),
        decoration: const InputDecoration(
          border: InputBorder.none,
          counterText: "",
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Enter verification code",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Row(
                children: [
                  const Text(
                    "Enter the verification code sent to ",
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    widget.email,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 35),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (i) => otpBox(i)),
              ),

              const SizedBox(height: 35),

              /// ⭐ Gradient button
              GradientButton(
                  text: "Continue",
                  onPressed: () async {
                    String otp = controllers.map((c) => c.text).join();

                    if (otp.length != 6) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Enter 6-digit OTP")),
                      );
                      return;
                    }

                    final provider =
                        Provider.of<OtpController>(context, listen: false);

                    final result = await provider.verifyOtp(widget.email, otp);

                    if (result != null) {
                      String token = result['token'];

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => NameScreen(
                            token: token,
                            email: widget.email,
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Invalid OTP!")),
                      );
                    }
                  }),

              const SizedBox(height: 22),

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Didn’t receive the code? "),
                    Text(
                      "Resend",
                      style: TextStyle(
                        color: seconds == 0
                            ? Colors.deepPurple
                            : Colors.grey.shade500,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(" in $seconds second"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
