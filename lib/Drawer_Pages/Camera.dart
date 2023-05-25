import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class Camera extends StatefulWidget {
  const Camera({Key? key}) : super(key: key);

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  File? image;
  Future pickImage(ImageSource source) async{
    try {
      final image = await ImagePicker().pickImage(
          source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    }
    on PlatformException catch(e){
      print('Failed to pick the image from gallery: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Container(

    );
  }
}
