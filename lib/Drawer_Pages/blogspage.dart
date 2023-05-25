
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class BlogsPage extends StatelessWidget {

   @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          title:Text('BlogsPage'),
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
        body: Center(
            child:Column(
              children: [
                Text("BlogsPage",style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.normal
                ),
                    ),]



    )));
    //return const Placeholder();
  }
}
