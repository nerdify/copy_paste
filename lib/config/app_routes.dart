import 'package:copy_paste/features/list_notes/presentation/list_notes_screen.dart';
import 'package:copy_paste/features/splashscreen/intro_screen.dart';
import 'package:copy_paste/features/splashscreen/splash_screen.dart';
import 'package:flutter/cupertino.dart';

class AppRoute {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return ListNotesScreen.route();
      case SplashScreen.routeName:
        return SplashScreen.route();
      case IntroScreen.routeName:
        return IntroScreen.route();

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => const CupertinoPageScaffold(
        child: Center(
          child: Text('Error'),
        ),
      ),
    );
  }
}
