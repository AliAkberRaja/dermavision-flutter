import 'package:derma_vision/Main%20Page%20Screens/navigation_drawer_widget.dart';
import 'package:derma_vision/utils/color_utils.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Container(
      child:  Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          centerTitle: true,
          backgroundColor: hexStringToColor('00BCD4'),
          elevation: 0.0,
          leadingWidth: 50,
        ),
          drawer: NavigationDrawerWidget(),
            body: Center(child: Text('Profile',
              style: TextStyle(fontSize: 24),
      ),
      )
      )
    )
    ;
  }

