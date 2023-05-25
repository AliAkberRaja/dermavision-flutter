import 'package:flutter/material.dart';

import '../utils/color_utils.dart';

class UserPage extends StatelessWidget {
  final String name;
  final String urlImage;
  const UserPage({
    Key? key,
    required this.name,
    required this.urlImage,
}): super (key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: hexStringToColor("FFA372"),
        title: Text(name),
        centerTitle: true,

      ),
      body:
      FadeInImage.assetNetwork(
        placeholder: 'assets/male.jpg',
        image: urlImage,
        fit: BoxFit.contain,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        imageErrorBuilder: (context, error, stackTrace) {
          // Fallback to asset image if network image fails to load
          return Image.asset(
            'assets/male.jpg',
            fit: BoxFit.contain,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          );
        },
      )





    );
  }
}
