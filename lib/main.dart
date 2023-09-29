import 'package:copy_paste/app/app.dart';
import 'package:copy_paste/features/auth/presentation/bloc/cubit/auth_cubit.dart';
import 'package:copy_paste/features/auth/repository/implementations/auth_repository.dart';
import 'package:copy_paste/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final authCubit = AuthCubit(AuthRepository());

  runApp(
    BlocProvider(
      create: (context) => authCubit..init(),
      child: MyApp.create(),
    ),
  );
}
