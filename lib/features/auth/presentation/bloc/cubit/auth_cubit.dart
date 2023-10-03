import 'dart:async';

import 'package:copy_paste/features/auth/repository/auth_repository.dart';
import 'package:copy_paste/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Enum will all possible authentication states.
enum AuthState {
  initial,
  signedOut,
  signedIn,
}

// Extends Cubit and will emit states of type AuthState
class AuthCubit extends Cubit<AuthState> {
  // Get the injected AuthRepository
  final AuthRepository _authRepository = getIt();
  StreamSubscription? _authSubscription;

  AuthCubit() : super(AuthState.initial);

  Future<void> init() async {
    // Subscribe to listen for changes in the authentication state
    await Future.delayed(const Duration(seconds: 1));
    _authSubscription =
        _authRepository.onAuthStateChanged.listen(_authStateChanged);
  }

  // Helper function that will emit the current authentication state
  void _authStateChanged(String? userUID) {
    userUID == null ? emit(AuthState.signedOut) : emit(AuthState.signedIn);
  }

  // Sign-out and immediately emits signedOut state
  Future<void> signOut() async {
    await _authRepository.signOut();
    emit(AuthState.signedOut);
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
