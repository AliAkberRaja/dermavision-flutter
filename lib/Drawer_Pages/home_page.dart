import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:derma_vision/Drawer_Pages/_selectimage.dart';
import 'package:derma_vision/Drawer_Pages/Skinsurvey.dart';
import 'package:derma_vision/Drawer_Pages/apitest.dart';
import 'package:derma_vision/Drawer_Pages/newPatient.dart';
import 'package:derma_vision/Drawer_Pages/results.dart';
import 'package:derma_vision/Drawer_Pages/settings_user.dart';
import 'package:derma_vision/reusable_widget/reusable_widget.dart';
import 'package:derma_vision/utils/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

import 'blogspage.dart';

class HomePage extends StatefulWidget {


  @override
  State<HomePage> createState() => _HomePageState();



}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;




  File? image;
  //final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String myId = '';
 var myUsername="User";
  String myUrlAvatar = '';
   String email="";
 String useruid='';
  final urlImage = 'https://aliakberraja.github.io/profile/images/ali.jpg';







  Future<void> fetchUserDetails() async {
    User? user = auth.currentUser;
    if (user != null) {
      String uid = user.uid;

      try {
        DocumentSnapshot snapshot =
        await firestore.collection('UserData').doc(uid).get();

        if (snapshot.exists) {
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

          // Access the user's login details
         email = data['email'];
          myUsername = data['username'];

          // Do something with the login details
          print('User email: $email');
          print('User display name: $myUsername');
        } else {
          print('User data does not exist in Firestore');
        }
      } catch (error) {
        print('Failed to fetch user data from Firestore: $error');
      }
    } else {
      print('No user is currently logged in');
    }
  }

  // Future pickImage(ImageSource source) async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: source);
  //     if (image == null) return;
  //     final imageTemporary = File(image.path);
  //     setState(() {
  //       this.image = imageTemporary;
  //     });
  //   } on PlatformException catch (e) {
  //     print('Failed to pick the image from gallery: $e');
  //   }
  // }




  Widget build(BuildContext context) {



      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            child: Column(children: [
          const SizedBox(
            height: 1,
          ),

          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello,',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Text(
                        myUsername != null ? myUsername : 'User',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  //profile picture
                  Container(
                      padding: const EdgeInsets.all(10),
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      // child: image != null
                      //     ? Image.file(
                      //   image!,):

                      child:
                      ClipOval(
                        child: FadeInImage(
                          placeholder: AssetImage('assets/male.jpg'),
                          image: NetworkImage(urlImage),
                          fit: BoxFit.contain,
                          imageErrorBuilder: (context, error, stackTrace) {
                            return CircleAvatar(
                              radius: 40,
                              backgroundImage: AssetImage('assets/male.jpg'),
                              backgroundColor: hexStringToColor("00BCD4"),
                            );
                          },
                        ),
                      ),






                  )
                ],
              )),
          const SizedBox(
            height: 10,
          ),
          //card->how do you feel
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.cyan.shade50,
                  borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  // animation or icon
                  Container(
                    height: 130,
                    width: 130,
                    decoration: const BoxDecoration(
                        // color: Colors.cyan.shade200,
                        image: DecorationImage(
                      image: AssetImage('assets/getstarted.png'),
                    )),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  //how do you fee + get started button
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'How do you feel?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        'Start your Derma Vision Journey Now.',
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      ElevatedButton(

                        onPressed: ()  {
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => NewPatient()));

                            Navigator.of(context,rootNavigator: true).push(
                                SwipeablePageRoute(builder: (context) => NewPatient()));
                        },
                        style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                        elevation: MaterialStateProperty.all(0),
                        overlayColor: MaterialStateProperty.all(Colors.white12),
                        padding: MaterialStateProperty.all(EdgeInsets.all(0)),
                      ),
                        child: Container(

                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: hexStringToColor("00BCD4"),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              'Get Started  ',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ))
                ],
              ),
            ),
          ),
          //search bar
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding:  EdgeInsets.only(top: 3,bottom: 3),
                child: const TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search,size: 22,),
                    border: InputBorder.none,
                    hintText: 'How can we help you?',
                  ),
                ),
              ),
            ),
          ),
          //horizontal Listview-> categories
          const SizedBox(
            height: 20,
          ),
          Container(
              height: 130,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                 InkWell(
                     child: GalleryButton()
                 ,onTap: (){
                   Navigator.of(context,rootNavigator: true).push(
                       SwipeablePageRoute(builder: (context) => SelectImage()));
                 },),
                  InkWell(
                    child: ResultButton()
                    ,onTap: (){
                    Navigator.of(context,rootNavigator: true).push(
                        SwipeablePageRoute(builder: (context) => Results()));
                  },),
                  InkWell(
                    child: SettingsButton()
                    ,onTap: (){Navigator.of(context,rootNavigator: true).push(
                      SwipeablePageRoute(builder: (context) => SettingsPage()));},),
                  InkWell(
                    child: BlogButton()
                    ,onTap: (){
                    Navigator.of(context,rootNavigator: true).push(
                        SwipeablePageRoute(builder: (context) => Apitest()));
                  },),





                ],
              )),
          SizedBox(
            height: 10,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 25.0,right:25.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Skin Survey',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          'Get your Analysis through Questionnaire',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal), //any users name
                        ),
                      ],
                    ),
                    //profile picture
                  ])),SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0,right: 25.0, bottom: 25.0),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    borderRadius: BorderRadius.circular(12),

                  ),
                  child: Row(
                    children: [

                      const SizedBox(
                        width: 20,
                      ),
                      //how do you fee + get started button
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                'Fill a Survey to know about your skin.',
                                style: TextStyle(fontSize: 14),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              InkWell(
                                onTap: (){
                                  Navigator.of(context,rootNavigator: true).push(
                                      SwipeablePageRoute(builder: (context) => SkinSurvey()));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.deepPurple.shade300,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Survey ',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ))
                      ,Container(
                        height: 150,
                        width: 180,
                        decoration: const BoxDecoration(
                          // color: Colors.cyan.shade200,
                            image: DecorationImage(
                              image: AssetImage('assets/questionaire.png'),
                            )),

                      ),
                    ],
                    ),
                  ),
                ),


        ])));
  }
}
