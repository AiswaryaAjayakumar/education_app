import 'package:education_app/view/profile_screen/profile_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';


GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email', 'profile'],
);

Future<void> handleGoogleLogin(BuildContext context) async {
  try {
    final GoogleSignInAccount? account = await _googleSignIn.signIn();

    if (account == null) return;

    final GoogleSignInAuthentication auth =
        await account.authentication;

    final String? idToken = auth.idToken;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProfileScreen(
          fullName: account.displayName ?? "",
          email: account.email,
          photoUrl: account.photoUrl,
          token: idToken, 
        ),
      ),
    );
  } catch (e) {
    print("GOOGLE LOGIN ERROR: $e");
  }
}


