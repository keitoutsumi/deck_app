import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelector extends StatefulWidget {
  final Function(String) onImageSelected;
  final String? imagePath;

  ImageSelector({required this.onImageSelected, this.imagePath});

  @override
  _ImageSelectorState createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  late String _imagePath;

  @override
  void initState() {
    super.initState();
    _imagePath = widget.imagePath ?? '';
  }

  void _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
      widget.onImageSelected(_imagePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.camera),
              onPressed: () => _getImage(ImageSource.camera),
            ),
            IconButton(
              icon: Icon(Icons.photo_library),
              onPressed: () => _getImage(ImageSource.gallery),
            ),
          ],
        ),
        if (_imagePath.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.file(File(_imagePath)),
          ),
      ],
    );
  }
}
