import 'package:camera/camera.dart';
import 'package:copy_paste/app/app.dart';
import 'package:copy_paste/features/auth/presentation/bloc/cubit/auth_cubit.dart';
import 'package:copy_paste/features/auth/repository/auth_repository.dart';
import 'package:copy_paste/features/auth/repository/implementations/auth_repository.dart';
import 'package:copy_paste/features/auth/repository/implementations/my_notes_repository.dart';
import 'package:copy_paste/features/auth/repository/my_notes_repository.dart';
import 'package:copy_paste/features/list_notes/data_source/data_source.dart';
import 'package:copy_paste/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';

// Create a global instance of GetIt that can be used later to
// retrieve our injected instances
final getIt = GetIt.instance;

late List<CameraDescription> cameras;

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// Splash screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Inject dependencies
  await injectDependencies();

  /// Get the list of available cameras.
  cameras = await availableCameras();

  runApp(
    // AuthCubit will be at the top of the widget tree
    BlocProvider(
      create: (_) => AuthCubit()..init(),
      child: const MyApp(),
    ),
  );
}

// Helper function to inject dependencies
Future<void> injectDependencies() async {
  // Inject the data sources.
  getIt.registerLazySingleton(() => FirebaseDataSource());

  // Inject the Repositories. Note that the type is the abstract class
  // and the injected instance is the implementation.
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImp());
  getIt.registerLazySingleton<MyNotesRepository>(() => MyNotesRepositoryImp());
}
