
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:derma_vision/Login%20Screens/register.dart';
import 'package:derma_vision/Login%20Screens/resetpassword.dart';
import 'package:derma_vision/utils/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../reusable_widget/reusable_widget.dart';
import '../Main Page Screens/dashboard.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {

  final storage = new FlutterSecureStorage();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  // Future<void> storetoke(UserCredential usercredential) async{
  //
  //   await storage.write(key: 'token', value: usercredential.credential.toString());
  //   await storage.write(key: 'userCredential', value: usercredential.toString());
  // }


  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
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
                  padding: EdgeInsets.fromLTRB(
                      20, MediaQuery
                      .of(context)
                      .size
                      .height * 0.2, 20, 0),
                  child: Column(children: <Widget>[
                    logoWidget('assets/loginvector.png')
                    ,
                    const SizedBox(
                      height: 30,
                    ),
                    reusableTextField(
                        'Enter Email', Icons.person_outline, false,
                        _emailTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField(
                        'Enter Password', Icons.lock_outline, true,
                        _passwordTextController),
                    const SizedBox(
                      height: 4,
                    ),
                    forgetPassword(context),
                    const SizedBox(
                      height: 10,
                    ),
                    firebaseButton(context, "Sign In", () {
                     // UserCredential usercredential = await FirebaseAuth.instance.signInWithCredential(credential);

                      FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text).then((value) {
                       // storetoke(usercredential);

                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => Dashboard()));

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text('Login Successfull!'),
                          backgroundColor: Colors.deepOrangeAccent.shade100,
                        ));
                      }).onError((error, stackTrace) {
                        print("Error ${error.toString()}");
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:  Text('Error ${error.toString()}'),
                          backgroundColor: Colors.deepOrangeAccent.shade100,
                        ));
                      });
                    }),
                signUpOption()
    ],
                  )
              )
          ),
        ),
      );
  }


  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have accont?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(this.context, MaterialPageRoute(builder: (context) => MyRegister()));
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
  Widget forgetPassword(BuildContext context)
  {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
child: const Text(
  "Forgot Password?",
  style: TextStyle(color: Colors.white70),
  textAlign: TextAlign.right,
),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPassword())),
      ),
    );
  }
}

