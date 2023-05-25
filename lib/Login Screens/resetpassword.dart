import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:derma_vision/Login%20Screens/login.dart';
import 'package:derma_vision/reusable_widget/reusable_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/color_utils.dart';
import '../Main Page Screens/dashboard.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  TextEditingController _EmailTextController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Reset Password", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                  height: 10,
                ),
                reusableTextField("Enter Email", Icons.email_outlined, false, _EmailTextController),
                const SizedBox(
                  height: 15,
                ),
            firebaseButton(context, "Reset Password", (){
              FirebaseAuth.instance.sendPasswordResetEmail(email: _EmailTextController.text).then((value)=> Navigator.of(context).pop());
            })


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
            "Sign In",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

}
