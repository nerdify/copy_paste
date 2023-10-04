// Replace with your client id
import 'dart:io';

import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_facebook/firebase_ui_oauth_facebook.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:page_indicator/page_indicator.dart';

final googleClientId = kIsWeb || Platform.isAndroid
    ? 'your-android-and-web-client-id'
    : 'your-ios-client-id';

// Replace with your client id
const facebookClientId = 'your-facebook-client-id';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: _IntroPager(),
    );
  }
}

class _IntroPager extends StatelessWidget {
  final String exampleText =
      'Lorem ipsum dolor sit amet, consecrated advising elit, '
      'sed do eiusmod tempor incididunt ut labore et '
      'dolore magna aliqua. Ut enim ad minim veniam.';

  @override
  Widget build(BuildContext context) {
    return PageIndicatorContainer(
      padding: const EdgeInsets.only(bottom: 40),
      align: IndicatorAlign.bottom,
      shape: IndicatorShape.roundRectangleShape(size: const Size.square(8)),
      length: 4,
      indicatorSpace: 10,
      indicatorColor: CupertinoColors.systemGrey,
      indicatorSelectorColor: CupertinoColors.black,
      child: PageView(
        children: [
          _DescriptionPage(
            text: exampleText,
            imagePath: 'assets/intro_1.png',
          ),
          _DescriptionPage(
            text: exampleText,
            imagePath: 'assets/intro_2.png',
          ),
          _DescriptionPage(
            text: exampleText,
            imagePath: 'assets/intro_3.png',
          ),
          _LoginPage(),
        ],
      ),
    );
  }
}

class _DescriptionPage extends StatelessWidget {
  final String text;
  final String imagePath;

  const _DescriptionPage({
    required this.text,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          imagePath,
          width: 200,
          height: 200,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}

class _LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      providers: [
        GoogleProvider(clientId: googleClientId),
        FacebookProvider(clientId: facebookClientId),
        EmailAuthProvider(),
      ],
    );
  }
}
