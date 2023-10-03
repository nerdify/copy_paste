import 'dart:io';

import 'package:copy_paste/features/list_notes/model/my_notes.dart';

abstract class MyNotesRepository {
  String newId();

  Stream<Iterable<MyNotes>> getMyUsers();

  Future<void> saveMyUser(MyNotes myNotes, File? image);

  Future<void> deleteMyUser(MyNotes myNotes);
}
