// Replace with your client id
import 'dart:io';

import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final googleClientId = kIsWeb || Platform.isAndroid
    ? 'your-android-and-web-client-id'
    : 'your-ios-client-id';

// Replace with your client id
const facebookClientId = 'your-facebook-client-id';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _LoginPage(),
    );
  }
}

class _LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      providers: [
        GoogleProvider(clientId: googleClientId),
        EmailAuthProvider(),
      ],
    );
  }
}
