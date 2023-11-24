import 'package:copy_paste/features/list_notes/presentation/edit_note_screen.dart';
import 'package:copy_paste/features/list_notes/presentation/list_notes_screen.dart';
import 'package:copy_paste/features/splashscreen/intro_screen.dart';
import 'package:copy_paste/features/splashscreen/splash_screen.dart';
import 'package:flutter/material.dart';

import '../features/list_notes/presentation/edit_note_image_screen.dart';

class Routes {
  static const splash = '/';
  static const intro = '/intro';
  static const home = '/home';
  static const editNote = '/editNote';
  static const editNoteImage = '/editNoteImage';

  static Route routes(RouteSettings settings) {
    // Helper nested function.
    MaterialPageRoute buildRoute(Widget widget) {
      return MaterialPageRoute(builder: (_) => widget, settings: settings);
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
      case editNoteImage:
        return buildRoute(const EditNoteImageScreen());
      default:
        throw Exception('Route does not exists');
    }
  }
}
