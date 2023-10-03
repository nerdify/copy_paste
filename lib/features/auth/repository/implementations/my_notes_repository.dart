import 'dart:io';

import 'package:copy_paste/features/auth/repository/my_notes_repository.dart';
import 'package:copy_paste/features/list_notes/data_source/data_source.dart';
import 'package:copy_paste/features/list_notes/model/my_notes.dart';
import 'package:copy_paste/main.dart';

class MyNotesRepositoryImp extends MyNotesRepository {
  final FirebaseDataSource _fDataSource = getIt();

  @override
  String newId() {
    return _fDataSource.newId();
  }

  @override
  Stream<Iterable<MyNotes>> getMyUsers() {
    return _fDataSource.getMyNotes();
  }

  @override
  Future<void> saveMyUser(MyNotes myNotes, File? image) {
    return _fDataSource.saveMyNotes(myNotes, image);
  }

  @override
  Future<void> deleteMyUser(MyNotes myNotes) {
    return _fDataSource.deleteMyNotes(myNotes);
  }
}
