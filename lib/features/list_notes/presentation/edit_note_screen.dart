import 'dart:io';

import 'package:copy_paste/features/auth/presentation/bloc/cubit/edit_my_notes_cubit.dart';
import 'package:copy_paste/features/list_notes/model/my_notes.dart';
import 'package:copy_paste/features/splashscreen/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditNoteScreen extends StatelessWidget {
  const EditNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final noteToEdit = ModalRoute.of(context)?.settings.arguments as MyNotes?;

    return BlocProvider(
      create: (context) => EditMyUserCubit(noteToEdit),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Note'),
        ),
        body: BlocConsumer<EditMyUserCubit, EditMyUserState>(
          listener: (context, state) {
            if (state.isDone) {
              // When isDone is true we navigate to the previous screen/route
              Navigator.of(context).pop();
            }
          },
          builder: (_, state) {
            return Stack(
              children: [
                _MyNoteSection(
                  notes: noteToEdit,
                  pickedImage: state.pickedImage,
                  isSaving: state.isLoading,
                ),
                if (state.isLoading)
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _MyNoteSection extends StatefulWidget {
  final MyNotes? notes;
  final File? pickedImage;
  final bool isSaving;

  const _MyNoteSection(
      {required this.notes, required this.pickedImage, this.isSaving = false});

  @override
  _MyUserSectionState createState() => _MyUserSectionState();
}

class _MyUserSectionState extends State<_MyNoteSection> {
  final _titleController = TextEditingController();
  final _descriptionNameController = TextEditingController();

  final picker = ImagePicker();

  @override
  void initState() {
    _titleController.text = widget.notes?.title ?? '';
    _descriptionNameController.text = widget.notes?.description ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            GestureDetector(
              onTap: () async {
                final editCubit = context.read<EditMyUserCubit>();
                final pickedImage =
                    await picker.pickImage(source: ImageSource.gallery);
                if (pickedImage != null) {
                  editCubit.setImage(File(pickedImage.path));
                }
              },
              child: Center(
                child: ClipOval(
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: CustomImage(
                      imageFile: widget.pickedImage,
                      imageUrl: widget.notes?.image,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 50),
            TextFormField(
              style: const TextStyle(fontSize: 18),
              key: const Key('Name'),
              controller: _titleController,
              maxLines: 2,
              // decoration: BoxDecoration(
              //   border: Border.all(color: CupertinoColors.systemGrey),
              //   borderRadius: BorderRadius.circular(8),
              // ),
            ),

            const SizedBox(height: 10),
            TextFormField(
              style: const TextStyle(fontSize: 18),
              key: const Key('Last Name'),
              controller: _descriptionNameController,
              maxLines: 10,
            ),

            const SizedBox(height: 15),

            // When isSaving is true we disable the button
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.purple.shade300,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              key: const Key(
                'Save',
              ),
              onPressed: widget.isSaving
                  ? null
                  : () {
                      context.read<EditMyUserCubit>().saveMyUser(
                            _titleController.text,
                            _descriptionNameController.text,
                          );
                    },
              child: const Text('Save', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
