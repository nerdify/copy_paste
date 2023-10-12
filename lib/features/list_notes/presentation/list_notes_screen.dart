import 'package:copy_paste/config/app_routes.dart';
import 'package:copy_paste/features/auth/presentation/bloc/cubit/auth_cubit.dart';
import 'package:copy_paste/features/auth/presentation/bloc/cubit/edit_my_notes_cubit.dart';
import 'package:copy_paste/features/auth/presentation/bloc/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

class ListNotesScreen extends StatelessWidget {
  const ListNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('List Copy Paste'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: TextButton(
                    child: const Text('Add Note'),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, Routes.editNote);
                    },
                  ),
                ),

                PopupMenuItem(
                  child: TextButton(
                    child: const Text('Add Image Note'),
                    onPressed: () {},
                  ),
                ),

                ///
                PopupMenuItem(
                  child: TextButton(
                    child: const Text('Logout'),
                    onPressed: () {
                      context.read<AuthCubit>().signOut();
                    },
                  ),
                ),
              ];
            },
          ),
        ],
      ),
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

                return GestureDetector(
                  onLongPress: () {
                    Clipboard.setData(
                      ClipboardData(text: myNote.description),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      shadowColor: Colors.grey.shade200,
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.editNote,
                            arguments: myNote,
                          );
                        },
                        title: Text(
                          myNote.description,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              elevation: 0,
                              showDragHandle: true,
                              context: context,
                              builder: (context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    /// Edit
                                    ListTile(
                                      trailing: const Icon(Icons.edit),
                                      title: const Text('Edit'),
                                      onTap: () {
                                        Navigator.pop(context);
                                        Navigator.pushNamed(
                                            context, Routes.editNote,
                                            arguments: myNote);
                                      },
                                    ),

                                    /// Share
                                    ListTile(
                                      trailing: const Icon(Icons.share),
                                      title: const Text('Share'),
                                      onTap: () {
                                        Share.share(myNote.description);
                                      },
                                    ),

                                    /// Delete
                                    ListTile(
                                      trailing: const Icon(Icons.delete),
                                      title: const Text('Delete'),
                                      onTap: () {},
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.more_vert),
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
