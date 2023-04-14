import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelector extends StatefulWidget {
  final String? initialImage;
  final void Function(String imagePath) onImageSelected;

  ImageSelector({required this.onImageSelected, this.initialImage});

  @override
  _ImageSelectorState createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _imagePath = widget.initialImage;
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
      widget.onImageSelected(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _getImage,
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
        ),
        child: _imagePath != null
            ? Image.file(
                File(_imagePath!),
                fit: BoxFit.cover,
              )
            : Icon(
                Icons.add_photo_alternate,
                color: Colors.grey,
              ),
      ),
    );
  }
}
