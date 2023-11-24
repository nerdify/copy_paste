import 'package:copy_paste/config/app_routes.dart';
import 'package:copy_paste/features/auth/presentation/bloc/cubit/auth_cubit.dart';
import 'package:copy_paste/features/auth/presentation/bloc/cubit/edit_my_notes_cubit.dart';
import 'package:copy_paste/features/auth/presentation/bloc/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:share_plus/share_plus.dart';

class ListNotesScreen extends StatelessWidget {
  const ListNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: SpeedDial(
        elevation: 5,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: const IconThemeData(
          size: 22,
          color: Colors.white,
        ),
        backgroundColor: Colors.purple.shade300,
        visible: true,
        curve: Curves.bounceIn,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.add, color: Colors.white),
            backgroundColor: Colors.purple.shade300,
            onTap: () {
              Navigator.pushNamed(context, Routes.editNote);
            },
            label: 'Add Note',
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 16.0,
            ),
            labelBackgroundColor: Colors.purple.shade300,
          ),
          SpeedDialChild(
            child: const Icon(Icons.add_a_photo, color: Colors.white),
            backgroundColor: Colors.purple.shade300,
            onTap: () {
              Navigator.pushNamed(context, Routes.editNoteImage);
            },
            label: 'Add Image Note',
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 16.0,
            ),
            labelBackgroundColor: Colors.purple.shade300,
          ),
          SpeedDialChild(
            child: const Icon(Icons.logout, color: Colors.white),
            backgroundColor: Colors.purple.shade300,
            onTap: () {
              context.read<AuthCubit>().signOut();
            },
            label: 'Logout',
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 16,
            ),
            labelBackgroundColor: Colors.purple.shade300,
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text('My Notes'),
        centerTitle: true,
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
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 2,
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
