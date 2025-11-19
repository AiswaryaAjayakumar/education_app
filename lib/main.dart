import 'package:education_app/controller/name_controller/name_controller.dart';
import 'package:education_app/controller/otp_controller/otp_controller.dart';
import 'package:education_app/controller/profile_controller/profile_controller.dart';
import 'package:education_app/controller/subject_controller/subject_controller.dart';
import 'package:education_app/view/home_screen/home_screen.dart';
import 'package:education_app/view/login_screen/login_screen.dart';
import 'package:education_app/view/profile_screen/profile_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const EducationApp());
}

class EducationApp extends StatelessWidget {
  const EducationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OtpController()),
        ChangeNotifierProvider(create: (_) => NameController()),
        ChangeNotifierProvider(create: (_) => ProfileController()),
        ChangeNotifierProvider(create: (_) => SubjectController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Login UI",
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
