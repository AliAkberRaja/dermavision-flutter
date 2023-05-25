import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('About Us'),
          centerTitle: true,
          backgroundColor: Colors.deepOrangeAccent.shade100,
        ),
      );
}
