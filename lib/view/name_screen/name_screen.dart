import 'package:education_app/controller/name_controller/name_controller.dart';
import 'package:education_app/view/profile_screen/profile_screen.dart';
import 'package:education_app/view/widgets/email_texfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/gradient_button.dart';

class NameScreen extends StatefulWidget {
  final String token;
  final String email;

  const NameScreen({
    super.key,
    required this.token,
    required this.email,
  });

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final fullnameProvider = Provider.of<NameController>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔙 BACK BUTTON
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Row(
                  children: [
                    Icon(Icons.arrow_back, size: 22),
                    SizedBox(width: 6),
                    Text("Back", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                "What’s your name?",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 35),

              EmailTextField(
                controller: nameController,
                hint: "Enter your full name",
                icon: Icons.person,
              ),

              const SizedBox(height: 30),

              fullnameProvider.loading
                  ? const Center(child: CircularProgressIndicator())
                  : GradientButton(
                      text: "Continue",
                      onPressed: () async {
                        String name = nameController.text.trim();

                        if (name.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Please enter your name")),
                          );
                          return;
                        }

           
                        bool success = await fullnameProvider.addFullname(
                          name,
                          widget.token,
                        );

                        if (success) {
     
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProfileScreen(
                                fullName: name,
                                email: widget.email,
                                token: widget.token, 
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(fullnameProvider.message ??
                                  "Something went wrong. Try again."),
                            ),
                          );
                        }
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
