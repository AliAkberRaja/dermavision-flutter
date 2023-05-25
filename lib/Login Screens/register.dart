import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:derma_vision/Login%20Screens/login.dart';
import 'package:derma_vision/reusable_widget/reusable_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../utils/color_utils.dart';
import '../Main Page Screens/dashboard.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  State<MyRegister> createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  TextEditingController _PasswordTextController = TextEditingController();
  TextEditingController _EmailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Sign Up", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [hexStringToColor("FFA372"),
              hexStringToColor("00BCD4"),
              hexStringToColor("00BCD4")],
                begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 250, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter UserName", Icons.person_outline, false, _userNameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Email", Icons.email_outlined, false, _EmailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outline, true, _PasswordTextController),
                const SizedBox(
                  height: 40,
                ),
                firebaseButton(context, "Sign Up", () {
                  FirebaseAuth.instance.createUserWithEmailAndPassword(email: _EmailTextController.text,
                      password: _PasswordTextController.text).then
                    ((value){
                        FirebaseFirestore.instance.collection('UserData').doc(value.user?.uid).set({

                          "email": _EmailTextController.text,
                          "username": _userNameTextController.text,
                          "password": _PasswordTextController.text,
                          "imagelink":"none",
                        });

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text('Account Created Successfully, You can login now'),
                          backgroundColor: Colors.deepOrangeAccent.shade100,
                        ));
                  }
                  ).onError((error, stackTrace) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:  Text("Error ${error.toString()}"),
                      backgroundColor: Colors.deepOrangeAccent.shade100,
                    ));
                  });
                }),
                signInOption()
              ],
            ),
          ),
        ),

      ),

    );

  }
  Row signInOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyLogin()));
          },
          child: const Text(
            "Login",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

}
