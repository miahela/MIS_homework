import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _addImage() async {
    final pickedImage = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (pickedImage == null) return;

    setState(() {
      _storedImage = File(pickedImage.path);
    });

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(pickedImage.path);
    final savedImage = await _storedImage.copy('${appDir.path}/$filename');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text("No image taken"),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          // ignore: deprecated_member_use
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            label: Text("Take a picutre"),
            textColor: Theme.of(context).primaryColor,
            onPressed: _addImage,
          ),
        )
      ],
    );
  }
}
