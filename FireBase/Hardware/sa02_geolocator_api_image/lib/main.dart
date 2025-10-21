import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: ImagePickerScreen));
}

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}