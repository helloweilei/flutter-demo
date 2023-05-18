import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({
    Key? key,
    required this.onChange,
  }) : super(key: key);
  final void Function(File) onChange;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedFile;
  void _takePhoto() async {
    final imageFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 800,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _selectedFile = File(imageFile.path);
    });
    widget.onChange(_selectedFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: _selectedFile != null
          ? GestureDetector(
              onTap: _takePhoto,
              child: Image.file(
                _selectedFile!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            )
          : TextButton.icon(
              onPressed: _takePhoto,
              icon: const Icon(Icons.camera),
              label: const Text('Take photo'),
            ),
    );
  }
}
