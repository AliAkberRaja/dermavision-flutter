import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:derma_vision/Drawer_Pages/Aboutus.dart';
import 'package:derma_vision/Drawer_Pages/Camera.dart';
import 'package:derma_vision/Drawer_Pages/PharmacyScreen.dart';
import 'package:derma_vision/Drawer_Pages/blogspage.dart';
import 'package:derma_vision/Drawer_Pages/home.dart';
import 'package:derma_vision/Drawer_Pages/terms_and_conditions.dart';
import 'package:derma_vision/Login%20Screens/login.dart';
import 'package:derma_vision/Main%20Page%20Screens/navigation_drawer_widget.dart';
import 'package:derma_vision/reusable_widget/reusable_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:derma_vision/utils/color_utils.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

import '../Drawer_Pages/doctor.dart';
import '../Drawer_Pages/newPatient.dart';
import '../Drawer_Pages/pharmacy.dart';
import '../Drawer_Pages/profile.dart';
import 'DoctorScreen.dart';


class  Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {


  int _selectedIndex = 0; //used for google nav bar index
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Widget> _pages = [
    Home(),
    Doctor(),
    BlogsPage(),
    Pharmacy(),
  ];


  File? image;

  @override
  void initState() {
    super.initState();
  }


  Widget build(BuildContext context) {
    Future pickImage(ImageSource source) async{
      try {
        final image = await ImagePicker().pickImage(
            source: source);
        if (image == null) return;
        final imageTemporary = File(image.path);
        setState(() {
          this.image = imageTemporary;
        });
      }
      on PlatformException catch(e){
        print('Failed to pick the image from gallery: $e');
      }
    }

    return Scaffold(
        body: _pages[_selectedIndex],
        //selected index of navbar
        key: scaffoldKey,
        //used in changing icon

        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          backgroundColor: hexStringToColor("00BCD4"),
          elevation: 0.0,
          leadingWidth: 50,
          centerTitle: true,
          title: Text("DermaVision"),
          leading: IconButton(
            icon: FaIcon(FontAwesomeIcons.alignLeft),
            onPressed: () {
              if (scaffoldKey.currentState!.isDrawerOpen) {
                scaffoldKey.currentState!.closeDrawer();
                //close drawer, if drawer is open
              } else {
                scaffoldKey.currentState!.openDrawer();
                //open drawer, if drawer is closed
              }
            },
          ),
        ),


        bottomNavigationBar: Container(
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

                  GButton(icon: Icons.home,text: "Home", iconSize: 30,onPressed: (
                      ){
                   //  Navigator.of(context).pop();
                   //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> Dashboard()));
                   //  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                   //      Dashboard()), (Route<dynamic> route) => true);
                  },),

                  GButton(icon: Icons.medical_services,
                      text: "Doctor",
                      iconSize: 28,onPressed: (){},),

                  GButton(
                      icon: Icons.menu_book, text: "Blogs", iconSize: 28,onPressed: (){},),

                  GButton(icon: FontAwesomeIcons.syringe,
                      text: "Pharmacy",
                      iconSize: 25,onPressed: (){

                    },),

                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    print(index);
                    _selectedIndex = index;
                    if(_selectedIndex==2)
                      {

                      }

                  }
                  );
                }
            ),
          ),
        )
    );
  }
}







