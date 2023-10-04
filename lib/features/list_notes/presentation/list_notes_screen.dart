import 'package:copy_paste/config/app_routes.dart';
import 'package:copy_paste/features/auth/presentation/bloc/cubit/auth_cubit.dart';
import 'package:copy_paste/features/auth/presentation/bloc/cubit/edit_my_notes_cubit.dart';
import 'package:copy_paste/features/auth/presentation/bloc/cubit/home_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListNotesScreen extends StatelessWidget {
  const ListNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
        middle: const Text('List Copy Paste'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              child: const Icon(
                  CupertinoIcons.arrowshape_turn_up_right_circle_fill),
              onPressed: () {
                context.read<AuthCubit>().signOut();
              },
            ),
            CupertinoButton(
              child: const Icon(CupertinoIcons.add),
              onPressed: () {
                Navigator.pushNamed(context, Routes.editNote);
              },
            ),
          ],
        ),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => EditMyUserCubit(null),
          ),
          BlocProvider(
            create: (context) => HomeCubit()..init(),
          ),
        ],
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return ListView.builder(
              itemCount: state.myNotes.length,
              itemBuilder: (context, index) {
                final myNote = state.myNotes.elementAt(index);

                return Dismissible(
                  key: Key(myNote.id),
                  onDismissed: (direction) {
                    context.read<EditMyUserCubit>().deleteMyUser();
                  },
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    color: CupertinoColors.systemRed,
                    padding: const EdgeInsets.only(right: 24),
                    child: const Icon(
                      CupertinoIcons.delete,
                      color: CupertinoColors.white,
                    ),
                  ),
                  confirmDismiss: (direction) async {
                    return await showCupertinoDialog<bool>(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: const Text('Delete Copy Paste'),
                          content: const Text(
                              'Are you sure you want to delete this note?'),
                          actions: [
                            CupertinoDialogAction(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                            ),
                            CupertinoDialogAction(
                              child: const Text('Delete'),
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(
                        ClipboardData(text: myNote.description),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 8,
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          border: Border.fromBorderSide(
                            BorderSide(
                              color: CupertinoColors.systemGrey,
                            ),
                          ),
                        ),
                        child: CupertinoListTile(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.editNote,
                              arguments: myNote,
                            );
                          },
                          leading: const Icon(CupertinoIcons.doc_text),
                          title: Text(
                            myNote.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: const Icon(CupertinoIcons.right_chevron),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
