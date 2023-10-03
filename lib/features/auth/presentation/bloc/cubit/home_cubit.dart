import 'dart:async';

import 'package:copy_paste/features/auth/repository/my_notes_repository.dart';
import 'package:copy_paste/features/list_notes/model/my_notes.dart';
import 'package:copy_paste/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Extends Cubit and will emit states of the type HomeState
class HomeCubit extends Cubit<HomeState> {
  // Get the injected MyUserRepository
  final MyNotesRepository _notesRepository = getIt();
  StreamSubscription? _myNotesSubscription;

  HomeCubit() : super(const HomeState());

  Future<void> init() async {
    // Subscribe to listen for changes in the myUser list
    _myNotesSubscription = _notesRepository.getMyUsers().listen(myNotesListen);
  }

  // Every time the myUser list is updated, this function will be called
  // with the latest data
  void myNotesListen(Iterable<MyNotes> myNotes) async {
    emit(HomeState(
      isLoading: false,
      myNotes: myNotes,
    ));
  }

  @override
  Future<void> close() {
    _myNotesSubscription?.cancel();
    return super.close();
  }
}

// Class that will hold the state of this Cubit
// Extending Equatable will help us to compare if two instances
// are the same without override == and hashCode
class HomeState extends Equatable {
  final bool isLoading;
  final Iterable<MyNotes> myNotes;

  const HomeState({
    this.isLoading = true,
    this.myNotes = const [],
  });

  @override
  List<Object?> get props => [isLoading, myNotes];
}
