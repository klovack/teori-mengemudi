import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:roadcognizer/components/app_scaffold/app_scaffold.dart';

class ImageDisplayScreen extends StatefulWidget {
  final String imagePath;

  const ImageDisplayScreen(this.imagePath, {super.key});

  @override
  State<ImageDisplayScreen> createState() => _ImageDisplayScreenState();
}

class _ImageDisplayScreenState extends State<ImageDisplayScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(child: Image.file(File(widget.imagePath)));
  }
}
