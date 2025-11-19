import 'dart:io';
import 'package:education_app/controller/profile_controller/profile_controller.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

import 'package:education_app/view/congrats_screen/congrats_screen.dart';
import 'package:education_app/view/widgets/email_texfield.dart';
import 'package:education_app/view/widgets/gradient_button.dart';

class ProfileScreen extends StatefulWidget {
  final String fullName;
  final String email;
  final String? token;
  final String? phone;
  final String? photoUrl;

  const ProfileScreen({
    super.key,
    required this.fullName,
    required this.email,
    this.token,
    this.phone,
    this.photoUrl,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;

  File? localImage;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.fullName);
    emailController = TextEditingController(text: widget.email);
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() => localImage = File(picked.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileController>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Row(
                  children: [
                    Icon(Icons.arrow_back),
                    SizedBox(width: 6),
                    Text("Back"),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              const Text("Your Profile",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text("Profile Picture",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              const SizedBox(height: 15),
              Center(
                child: GestureDetector(
                  onTap: pickImage,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: localImage != null
                            ? FileImage(localImage!)
                            : (widget.photoUrl != null
                                ? NetworkImage(widget.photoUrl!)
                                : null),
                        child: (localImage == null && widget.photoUrl == null)
                            ? const Icon(Icons.camera_alt, size: 40)
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: pickImage,
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(Icons.add,
                                size: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text("Full Name", style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              EmailTextField(
                controller: nameController,
                hint: "Enter your full name",
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 20),
              const Text("Mail ID", style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              EmailTextField(
                controller: emailController,
                hint: "Enter your email",
                icon: Icons.email_outlined,
              ),
              const SizedBox(height: 30),
              GradientButton(
                text: profileProvider.isLoading ? "Uploading..." : "Continue",
                onPressed: () async {
                
                  if (localImage == null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CongratsScreen()),
                    );
                    return;
                  }

                  if (widget.token == null || widget.token!.isEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CongratsScreen()),
                    );
                    return;
                  }

                  final result = await profileProvider.uploadProfilePic(
                    widget.token!,
                    localImage!,
                  );

                  if (result != null && result["error"] == null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CongratsScreen()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(result?["error"] ?? "Upload failed")),
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
