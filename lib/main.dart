// ignore: avoid_web_libraries_in_flutter


import 'package:derma_vision/Drawer_Pages/home_page.dart';
import 'package:derma_vision/Drawer_Pages/newPatient.dart';
import 'package:derma_vision/Login%20Screens/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:derma_vision/Login%20Screens/login.dart';
import 'package:derma_vision/Main%20Page%20Screens/dashboard.dart';



void main()
 async {
   //Intializing firebase
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();


   runApp(MaterialApp(
     debugShowCheckedModeBanner: false,
     initialRoute: 'login',
     routes: {
       'login': (context) => MyLogin(),
       'register': (context) => MyRegister(),
       'dashboard': (context) => Dashboard(),
       'newpatient': (context) => NewPatient(),

     },
   ));
 }
