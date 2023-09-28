import 'package:copy_paste/features/splashscreen/splash_screen.dart';
import 'package:flutter/cupertino.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Copy with Me App',
      home: SplashScreen(),
    );
  }
}
