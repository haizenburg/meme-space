import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(imageSource) async {
  final ImagePicker _imagePicker = ImagePicker();

  var source;
  XFile? _file = await _imagePicker.pickImage(source: imageSource);

  if (_file != null) {
    return await _file.readAsBytes();
  }

  print('No image selected');
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(content),
  ));
}
