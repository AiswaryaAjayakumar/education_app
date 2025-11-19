import 'package:education_app/controller/otp_controller/otp_controller.dart';
import 'package:education_app/view/google_siging/google_signing.dart';
import 'package:education_app/view/otp_verification_screen/otp_verfication_screen.dart';
import 'package:education_app/view/register_screen/register_screen.dart';
import 'package:education_app/view/widgets/email_texfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/gradient_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
      
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Row(
                children: [
                  Icon(Icons.arrow_back, size: 22),
                  SizedBox(width: 5),
                  Text("Back", style: TextStyle(fontSize: 18)),
                ],
              ),
              const SizedBox(height: 35),
              const Text(
                "Email",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              EmailTextField(
                controller: emailController,
                hint: "penoftdesign@gmail.com",
                icon: Icons.email_outlined,
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: rememberMe,
                        onChanged: (value) {
                          setState(() => rememberMe = value!);
                        },
                      ),
                      const Text("Remember Me"),
                    ],
                  ),
                  const Text(
                    "Forgot Password?",
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              GradientButton(
                text: "Continue",
                onPressed: () async {
                  final email = emailController.text.trim();

                  if (email.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please enter email")),
                    );
                    return;
                  }

                  final otpProvider =
                      Provider.of<OtpController>(context, listen: false);

                  bool success = await otpProvider.sendOtp(email);

                  if (success) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => OtpVerificationScreen(email: email),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 25),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const RegisterScreen()),
                        );
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Expanded(child: Container(height: 1, color: Colors.grey)),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("OR"),
                  ),
                  Expanded(child: Container(height: 1, color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 25),
              GestureDetector(
                onTap: () => handleGoogleLogin(context),
                child: Container(
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        "https://upload.wikimedia.org/wikipedia/commons/4/4a/Logo_2013_Google.png",
                        height: 24,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        "Continue with Google",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
