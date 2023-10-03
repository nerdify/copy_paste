import 'package:copy_paste/features/list_notes/presentation/edit_note_screen.dart';
import 'package:copy_paste/features/list_notes/presentation/list_notes_screen.dart';
import 'package:copy_paste/features/splashscreen/intro_screen.dart';
import 'package:copy_paste/features/splashscreen/splash_screen.dart';

import 'package:flutter/cupertino.dart';

class Routes {
  static const splash = '/';
  static const intro = '/intro';
  static const home = '/home';
  static const editNote = '/editNote';

  static Route routes(RouteSettings settings) {
    // Helper nested function.
    CupertinoPageRoute buildRoute(Widget widget) {
      return CupertinoPageRoute(builder: (_) => widget, settings: settings);
    }

    switch (settings.name) {
      case splash:
        return buildRoute(const SplashScreen());
      case intro:
        return buildRoute(const IntroScreen());
      case home:
        return buildRoute(const ListNotesScreen());
      case editNote:
        return buildRoute(const EditNoteScreen());
      default:
        throw Exception('Route does not exists');
    }
  }
}
