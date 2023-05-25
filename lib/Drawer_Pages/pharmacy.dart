import 'package:derma_vision/Drawer_Pages/PharmacyScreen.dart';
import 'package:flutter/material.dart';

import '../Main Page Screens/DoctorScreen.dart';

class Pharmacy extends StatelessWidget {
  const Pharmacy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PharmacyPage(),
    theme: ThemeData(primarySwatch: Colors.cyan),
    );
  }
}
