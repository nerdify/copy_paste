import 'package:copy_paste/config/app_routes.dart';
import 'package:copy_paste/features/auth/presentation/bloc/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

final _navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state == AuthState.signedOut) {
          _navigatorKey.currentState
              ?.pushNamedAndRemoveUntil(Routes.intro, (r) => false);
        } else if (state == AuthState.signedIn) {
          _navigatorKey.currentState
              ?.pushNamedAndRemoveUntil(Routes.home, (r) => false);
        }
      },
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        title: 'Copy with Me App',
        onGenerateRoute: Routes.routes,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          primaryColor: Colors.purple,
          scaffoldBackgroundColor: Colors.white,
          textTheme: GoogleFonts.redHatDisplayTextTheme(),
        ),
      ),
    );
  }
}
