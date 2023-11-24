import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class EditNoteImageScreen extends StatefulWidget {
  const EditNoteImageScreen({super.key});

  @override
  State<EditNoteImageScreen> createState() => _EditNoteImageScreenState();
}

class _EditNoteImageScreenState extends State<EditNoteImageScreen> {
  late CameraController _controller;
  late String imagePath;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      const CameraDescription(
        name: '0',
        lensDirection: CameraLensDirection.back,
        sensorOrientation: 0,
      ),
      ResolutionPreset.medium,
    );
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':

            /// TODO: Handle this error
            break;
          default:

            /// TODO: Handle this error
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note Image'),
      ),
      body: Column(
        children: [
          Expanded(
            child: CameraPreview(_controller),
          ),
          // Expanded(
          //   child: TextButton(
          //     onPressed: () async {
          //       try {
          //         final XFile photo = await _controller.takePicture();
          //         _imageFile = File(photo.path);
          //         setState(() {});
          //         Navigator.of(context).pop();
          //       } catch (e) {
          //         ScaffoldMessenger.of(context).showSnackBar(
          //           SnackBar(content: Text('Failed to capture photo: $e')),
          //         );
          //       }
          //     },
          //     child: const Text('Save'),
          //   ),
          // ),

          ///
          const Divider(height: 1),

          ///
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () async {
                    try {
                      final XFile photo = await _controller.takePicture();
                      imagePath = photo.path;
                      setState(() {});
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to capture photo: $e')),
                      );
                    }
                  },
                  child: const Text('Save'),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
