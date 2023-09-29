import 'package:copy_paste/config/app_routes.dart';
import 'package:copy_paste/features/auth/presentation/bloc/cubit/auth_cubit.dart';
import 'package:copy_paste/features/list_notes/presentation/list_notes_screen.dart';
import 'package:copy_paste/features/splashscreen/intro_screen.dart';
import 'package:copy_paste/features/splashscreen/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

final _navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static Widget create() {
    return BlocListener<AuthCubit, AuthState>(
      listener: ((context, state) {
        if (state is AuthSignedOut) {
          _navigatorKey.currentState?.pushNamedAndRemoveUntil(
            IntroScreen.routeName,
            (route) => false,
          );
        } else if (state is AuthSignedIn) {
          _navigatorKey.currentState?.pushNamedAndRemoveUntil(
            ListNotesScreen.routeName,
            (route) => false,
          );
        }
      }),
      child: const MyApp(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      navigatorKey: _navigatorKey,
      title: 'Copy with Me App',
      onGenerateRoute: AppRoute.onGenerateRoute,
      initialRoute: SplashScreen.routeName,
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.systemPurple,
        scaffoldBackgroundColor: CupertinoColors.white,
        textTheme: CupertinoTextThemeData(
          textStyle: GoogleFonts.redHatDisplay()
              .copyWith(color: CupertinoColors.black),
        ),
        applyThemeToAll: true,
      ),
    );
  }
}
