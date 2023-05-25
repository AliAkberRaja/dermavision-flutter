import 'dart:ffi';
import 'package:derma_vision/Drawer_Pages/ViewDoctorDetails.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'dart:developer';

import 'package:derma_vision/Login%20Screens/login.dart';
import 'package:derma_vision/Main%20Page%20Screens/DoctorScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:image_picker/image_picker.dart';
import '../Drawer_Pages/home.dart';
import '../Login Screens/register.dart';
import '../utils/color_utils.dart';

Image logoWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 320,
    height: 180,
  );
}

TextField reusableTextField(String text, IconData icon, bool isPasswordtype,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordtype,
    enableSuggestions: isPasswordtype,
    autocorrect: isPasswordtype,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.white70,
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: isPasswordtype
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Container firebaseButton(BuildContext context, String title, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black26;
            }
            return Colors.white;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    ),
  );
}

// Scaffold BottomNavBar(int _selectedIndex){
// return Scaffold(
// bottomNavigationBar: Container(
// color: Colors.cyan.shade50,
// child:   Padding(
// padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 17.0),
// child: GNav(
// color: Colors.grey.shade600,
// activeColor: Colors.white,
// tabBackgroundGradient: LinearGradient(colors: [hexStringToColor("00BCD4"), const Color.fromRGBO(38, 208, 245, 0.28)], begin: Alignment.bottomLeft, end: Alignment.topRight),
// gap: 10,
//
// padding: const EdgeInsets.all(10),
//   tabs: const [
// GButton(icon: Icons.home, text: "Home",iconSize: 26),
//
// GButton(icon: Icons.medical_services, text: "Doctor",iconSize: 25),
//
// GButton(icon: Icons.camera_alt_rounded, text: "Camera",iconSize: 26),
//
// GButton(icon: Icons.person , text: "Profile",iconSize: 26),
//
// ],
//   selectedIndex: _selectedIndex,
//           onTabChange: (index) {
//
//   _selectedIndex = index;
//   }
//             )
//
//
// ),
// ),
// );}

Container CategoryCard(BuildContext context, String ImagePath,
    String TextofIcon, String HexColor) {
  return Container(
    padding: const EdgeInsets.only(left: 20.0),
    child: Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: hexStringToColor(HexColor),
      ),
      child: Row(
        children: [
          Image.asset(
            ImagePath,
            height: 30,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            TextofIcon,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    ),
  );
}


Column GalleryButton() {
  return Column(
      children:[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15,vertical: 0),
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
            gradient: LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment(0.8, 1),
  colors: <Color>[

    Colors.cyan.shade600,
    Colors.cyan.shade500,
    Colors.cyan.shade400,
    Colors.cyan.shade300,
    Colors.cyan.shade200,
    Colors.cyan.shade100,
  ],
  tileMode: TileMode.mirror,
  ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                spreadRadius: 1.5,
                blurRadius: 4,
                offset: Offset(4, 5), // changes position of shadow
              ),
            ],
            color: Colors.cyan,
          ),
          child: Icon(
            FontAwesomeIcons.camera
                ,size: 30,
            color : Colors.white,
          ),),
        SizedBox(height: 15,),
        Text(
          'Scan Now',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),

      ]


  );
}

Column ResultButton() {
  return Column(
      children:[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15,vertical: 0),
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0.8, 1),
              colors: <Color>[

                Colors.teal.shade600,
                Colors.teal.shade500,
                Colors.teal.shade400,
                Colors.teal.shade300,
                Colors.teal.shade200,
                Colors.teal.shade100,
              ],
              tileMode: TileMode.mirror,
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                spreadRadius: 1.5,
                blurRadius: 4,
                offset: Offset(4, 5), // changes position of shadow
              ),
            ],
            color: Colors.cyan,
          ),
          child: Icon(
            FontAwesomeIcons.flaskVial
            ,size: 30,
            color : Colors.white,
          ),),
        SizedBox(height: 15,),
        Text(
          'Results',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),

      ]


  );
}

Column SettingsButton() {
  return Column(
      children:[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15,vertical: 0),
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0.8, 1),
              colors: <Color>[

                Colors.deepOrange.shade600,
                Colors.deepOrange.shade500,
                Colors.deepOrange.shade400,
                Colors.deepOrange.shade300,
                Colors.deepOrange.shade200,
                Colors.deepOrange.shade100,
              ],
              tileMode: TileMode.mirror,
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                spreadRadius: 1.5,
                blurRadius: 4,
                offset: Offset(4, 5), // changes position of shadow
              ),
            ],
            color: Colors.cyan,
          ),
          child: Icon(
            FontAwesomeIcons.gears
            ,size: 30,
            color : Colors.white,
          ),),
        SizedBox(height: 15,),
        Text(
          'Settings',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),

      ]


  );
}

Column BlogButton() {
  return Column(
      children:[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15,vertical: 0),
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0.8, 1),
              colors: <Color>[

                Colors.deepPurple.shade600,
                Colors.deepPurple.shade500,
                Colors.deepPurple.shade400,
                Colors.deepPurple.shade300,
                Colors.deepPurple.shade200,
                Colors.deepPurple.shade100,
              ],
              tileMode: TileMode.mirror,
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                spreadRadius: 1.5,
                blurRadius: 4,
                offset: Offset(4, 5), // changes position of shadow
              ),
            ],
            color: Colors.cyan,
          ),
          child: Icon(
            FontAwesomeIcons.bookMedical
            ,size: 30,
            color : Colors.white,
          ),),
        SizedBox(height: 15,),
        Text(
          'Blogs',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),

      ]


  );
}


Container DoctorDisplay(
    BuildContext context,
    String Imagepath,
    String DoctorName,
    String type,
    String Rating,
    String Experience,
    String Fee,) {
  return Container(
      height: 200,
      margin: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 15),
      decoration: BoxDecoration(
        color: Colors.cyan.shade50,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.cyan.shade400.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20, top: 20),
                  height: 80,
                  width: 80,
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage(Imagepath),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          DoctorName,
                          style: TextStyle(
                            color: Color(0xff363636),
                            fontSize: 17,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              type,
                              style: TextStyle(
                                color: Color(0xffababab),
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: 15,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.stars_sharp,
                                        size: 20,
                                        color: Colors.orangeAccent.shade200,
                                      )),
                                  Container(
                                    child: Text(
                                      Rating,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontFamily: 'Roboto',
                                      ),
                                    ),
                                  ),
                                  Container(
                                      margin:
                                          EdgeInsets.only(left: 20, right: 10),
                                      child: Icon(
                                        FontAwesomeIcons.briefcaseMedical,
                                        size: 17,
                                        color: Colors.cyanAccent.shade400,
                                      )),
                                  Container(
                                    child: Text(
                                      Experience,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontFamily: 'Roboto',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: const Text(
                                      ' years',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontFamily: 'Roboto',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        margin:   EdgeInsets.only(top: 10),
                        child: Text(
                          "Total fee",
                          style: TextStyle(
                              color: Color(0xff5e5d5d),
                              fontSize: 14,
                              fontFamily: 'Roboto'),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Text(
                          Fee,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Roboto'),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                  //Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> ));
                    // Navigator.pushAndRemoveUntil(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => ViewDoctorDetails(),
                    //   ),
                    //       (route) => false,
                    // );
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 8),
                    height: 45,
                    width: 210,
                    decoration: BoxDecoration(
                      color: Colors.orange.shade400,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orangeAccent.shade100.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(0, 3),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Center(
                        child: Text(
                          "View Details",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ));
}

Container PharmacyDisplay(
    BuildContext context,
    String Imagepath,
    String PharmacyName,
    String type,
    String Rating,
    String Distance,

    ) {
  return Container(
      height: 120,
      margin: EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade500.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Column(
        children: [
          Container(
            child: Row(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, top: 10),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade400,
                      image: DecorationImage(
                        image: AssetImage(Imagepath),
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, top: 10),
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width * 0.6,
                      child:
                      Container(

                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10,),
                            child: Text(
                              PharmacyName,
                              style: TextStyle(
                                color: Color(0xff363636),
                                fontSize: 17,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(top: 10,),


                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.cyan.shade400,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 2,bottom: 2,left: 10,right: 10),

                                child: Text(
                                  Rating,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),

                            ),
                          )
                        ],
                      ))),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              type,
                              style: TextStyle(
                                color: Color(0xffababab),
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w300,
                                fontSize: 12,
                              ),
                            ),],),),

                            Container(
                              margin: EdgeInsets.only(top: 15,),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                children: [

                                  Container(
                                      margin: EdgeInsets.only(right: 5),
                                      child: Icon(
                                        FontAwesomeIcons.personWalking,
                                        size: 20,
                                        color: Colors.black45,
                                      )),
                                  Container(
                                    child: Text(
                                      Distance,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontFamily: 'Roboto',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 10,left: 50),
                                    height: 35,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade200,
                                      borderRadius: BorderRadius.circular(50),

                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5),
                                      child: Center(
                                        child: Text(
                                          "View Details",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              color: Colors.white,
                                              fontFamily: 'Roboto',
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ),


                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),





  );
}





 Container BottomNavBar(
int _selectedIndex,) {
   return Container(
     color: Colors.cyan.shade50,
     child: Padding(
       padding: const EdgeInsets.symmetric(
           horizontal: 17.0, vertical: 13.0),
       child: GNav(

           color: Colors.grey.shade600,
           activeColor: Colors.white,
           tabBackgroundGradient: LinearGradient(colors: [
             hexStringToColor("00BCD4"),
             const Color.fromRGBO(38, 208, 245, 0.28)
           ], begin: Alignment.bottomLeft, end: Alignment.topRight),
           gap: 10,


           padding: const EdgeInsets.all(10),
           tabs: [

             GButton(
               icon: Icons.home, text: "Home", iconSize: 30, onPressed: () {
             },),

             GButton(icon: Icons.medical_services,
               text: "Doctor",
               iconSize: 28, onPressed: () {},),

             GButton(
               icon: Icons.photo_camera,
               text: "Camera",
               iconSize: 28,
               onPressed: () {},),

             GButton(icon: FontAwesomeIcons.syringe,
               text: "Pharmacy",
               iconSize: 25, onPressed: () {

               },),

           ],
           selectedIndex: _selectedIndex,
           onTabChange: (index) {



               if (_selectedIndex == 0) {
                 _selectedIndex = index;

               }
               if (_selectedIndex == 1) {
                 _selectedIndex = index;

               }
               if (_selectedIndex == 2) {
                 _selectedIndex = index;
                 // pickImage(ImageSource.camera);
               }
               if (_selectedIndex == 3) {
                 _selectedIndex = index;
                 // pickImage(ImageSource.camera);
               }

             ;
           }
       ),
     ),
   );
 }

