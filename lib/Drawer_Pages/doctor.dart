import 'package:flutter/material.dart';
import '../Main Page Screens/DoctorScreen.dart';



class Doctor extends StatelessWidget {
  const Doctor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(

      debugShowCheckedModeBanner: false,
      home: DoctorPage(),
      theme: ThemeData(primarySwatch: Colors.cyan),
    );
  }
}
