import 'package:copy_paste/config/app_routes.dart';
import 'package:copy_paste/features/auth/presentation/bloc/cubit/auth_cubit.dart';
import 'package:copy_paste/features/auth/presentation/bloc/cubit/edit_my_notes_cubit.dart';
import 'package:copy_paste/features/auth/presentation/bloc/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListNotesScreen extends StatelessWidget {
  const ListNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('List Copy Paste'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthCubit>().signOut();
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, Routes.editNote);
            },
          ),
        ],
      ),
      // navigationBar: CupertinoNavigationBar(
      //   middle: const Text('List Copy Paste'),
      //   trailing: Row(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       CupertinoButton(
      //         child: const Icon(
      //             CupertinoIcons.arrowshape_turn_up_right_circle_fill),
      //         onPressed: () {
      //           context.read<AuthCubit>().signOut();
      //         },
      //       ),
      //       CupertinoButton(
      //         child: const Icon(CupertinoIcons.add),
      //         onPressed: () {
      //           Navigator.pushNamed(context, Routes.editNote);
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      body: MultiBlocProvider(
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
                    color: Colors.red,
                    padding: const EdgeInsets.only(right: 24),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  confirmDismiss: (direction) async {
                    return await showAdaptiveDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Delete Copy Paste'),
                          content: const Text(
                              'Are you sure you want to delete this note?'),
                          actions: [
                            TextButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                            ),
                            TextButton(
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
                            BorderSide(color: Colors.grey),
                          ),
                        ),
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.editNote,
                              arguments: myNote,
                            );
                          },
                          leading: const Icon(Icons.book_online_outlined),
                          title: Text(
                            myNote.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: const Icon(Icons.arrow_forward_outlined),
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
