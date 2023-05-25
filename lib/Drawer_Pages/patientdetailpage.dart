import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:derma_vision/Drawer_Pages/newPatient.dart';
import 'package:derma_vision/Drawer_Pages/pharmacy.dart';
import 'package:derma_vision/Main%20Page%20Screens/navigation_drawer_widget.dart';
import 'package:derma_vision/utils/color_utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'dart:math' as math;

import 'package:swipeable_page_route/swipeable_page_route.dart';

import '../Main Page Screens/DoctorScreen.dart';
import 'PharmacyScreen.dart';

class PatientDetailPage extends StatelessWidget {
  PatientDetailPage(
      {required this.PatientName, required this.gender,
        required this.Age,
        required this.DateofBirth,
        required this.DiseaseName,
        required this.Percentage,
        required this.diseaseimage,
        required this.testdate,
        required this.Condition,
        required this.ThreatLevel,
        required this.Risk,
        required this.Diagnosis,
        required this.Treatment,
        required this.Advice,

        Key? key})
      : super(key: key);

  final String Condition;
  final String ThreatLevel;
  final String Risk;
  final String Diagnosis;
  final String Treatment;
  final String Advice;
  final String gender;
  final String PatientName;
  final int Age;
  final String DateofBirth;
  final String DiseaseName;
  final String Percentage;
  final String testdate;
  final String diseaseimage;


  @override
  String checkgender(gen) {
    if (gender == 'Male') {
      gen = 'assets/male.jpg';
      return gen;
    } else if (gender == 'Female') {
      gen = 'assets/female.jpg';
      return gen;
    } else
      return gen = 'assets/male.jpg';
  }

  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
        centerTitle: true,
        backgroundColor: Colors.cyan,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(checkgender(gender)),
                      backgroundColor: Colors.cyanAccent.shade100,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: 160,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          PatientName,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          gender,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade500),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Age: "+ Age.toString(),
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade500),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Date of Birth: "+ DateofBirth,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade500),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
            Divider(
              height: 5,
              indent: 20.0,
              endIndent: 20.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.329,

              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5,),
                    child: Text('Test Details',style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5,),
                    child: Row(
                      children: [
                        SizedBox(width: 5,),
                        Icon(Icons.date_range_outlined,color: Colors.grey.shade600,size: 20,),
                        SizedBox(width: 3,),
                        Text('Test Date :',style: TextStyle(fontWeight: FontWeight.w500),),
                        SizedBox(width: 3,),
                        Text(testdate),
                      ],

                    ),

                  ),
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,

                    margin: const EdgeInsets.symmetric(vertical: 5,),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 5,),
                            Icon(FontAwesomeIcons.image,color: Colors.grey.shade600,size: 18,),
                            SizedBox(width: 5,),
                            Text('Skin Image :',style: TextStyle(fontWeight: FontWeight.w500),),
                          ],
                        ),

                        Container(
                          child: getImageWidget(diseaseimage)

                        ),

                      ],

                    ),

                  ),
                  const SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      Icon(FontAwesomeIcons.virus,color:  Colors.redAccent.shade100,size: 18,),
                      SizedBox(width: 10,),
                      Text('Disease Name :',style: TextStyle(fontWeight: FontWeight.w500),),
                      SizedBox(width: 10,),
                      Text(DiseaseName),
                    ],

                  ),
                  const SizedBox(height: 7,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(FontAwesomeIcons.bacteria,color: Colors.redAccent.shade100,size: 18,),
                      SizedBox(width: 10,),
                      Text('Condition :',style: TextStyle(fontWeight: FontWeight.w500),),
                      SizedBox(width: 10,),
                      Text(Condition),
                    ],

                  ),
                  const SizedBox(height: 7,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Icon(FontAwesomeIcons.skullCrossbones,color: Colors.redAccent.shade100,size: 18,),
                      SizedBox(width: 10,),
                      Text('Threat Level :',style: TextStyle(fontWeight: FontWeight.w500,),),
                      SizedBox(width: 10,),
                      Text(ThreatLevel),
                    ],

                  ),
                  const SizedBox(height: 7,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Icon(FontAwesomeIcons.percentage,color: Colors.redAccent.shade100,size: 18,),
                      SizedBox(width: 10,),
                      Text('Percentage :',style: TextStyle(fontWeight: FontWeight.w500),),
                      SizedBox(width: 10,),
                      Text(Percentage+"%"),
                    ],

                  ),



                ],
              ),
            ),
            const Divider(
              height: 10,
              indent: 20.0,
              endIndent: 20.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,

              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      SizedBox(width: 5,),
                      Icon(FontAwesomeIcons.personCircleCheck,color:  Colors.lightBlueAccent.shade700,size: 18,),
                      SizedBox(width: 10,),
                      Text('Risk Assesment :',style: TextStyle(fontWeight: FontWeight.w500),),
                      SizedBox(width: 10,),

                    ],

                  ),
                  SizedBox(height: 10,),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      height: MediaQuery.of(context).size.height*0.1,
                      width: MediaQuery.of(context).size.width,

                      child: Text(Risk)),
                  Row(


                    children: [
                      SizedBox(width: 5,),
                      Icon(FontAwesomeIcons.notesMedical,color:  Colors.lightBlueAccent.shade700,size: 18,),
                      SizedBox(width: 10,),
                      Text('Conclusion :',style: TextStyle(fontWeight: FontWeight.w500),),
                      SizedBox(width: 10,),
                      Text(Percentage + "% " + DiseaseName,style: TextStyle(fontWeight: FontWeight.w400),),
                    ],

                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      SizedBox(width: 5,),
                      Icon(FontAwesomeIcons.briefcaseMedical,color:  Colors.lightBlueAccent.shade700,size: 18,),
                      SizedBox(width: 10,),
                      Text('Precise Diagnosis :',style: TextStyle(fontWeight: FontWeight.w500),),
                    ],

                  ),

                  SizedBox(height: 5,),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      height: MediaQuery.of(context).size.height*0.04,
                      width: MediaQuery.of(context).size.width,

                      child: Text(Diagnosis)),
                  Row(
                    children: [
                      SizedBox(width: 5,),
                      Icon(FontAwesomeIcons.syringe,color:  Colors.lightBlueAccent.shade700,size: 18,),
                      SizedBox(width: 10,),
                      Text('Treatment :',style: TextStyle(fontWeight: FontWeight.w500),),
                    ],

                  ),

                  SizedBox(height: 5,),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      height: MediaQuery.of(context).size.height*0.04,
                      width: MediaQuery.of(context).size.width,

                      child: Text(Treatment)),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      SizedBox(width: 5,),
                      Icon(FontAwesomeIcons.commentMedical,color:  Colors.lightBlueAccent.shade700,size: 18,),
                      SizedBox(width: 10,),
                      Text('Advice :',style: TextStyle(fontWeight: FontWeight.w500),),

                    ],

                  ),
                  SizedBox(height: 5,),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      height: MediaQuery.of(context).size.height*0.04,
                      width: MediaQuery.of(context).size.width,

                      child: Text(Advice)),
                ],
              ),

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context,).push(SwipeablePageRoute(
                        builder: (BuildContext context) => (PharmacyPage())));
                  },
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.cyan.shade400,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.cyan.shade400.withOpacity(0.4),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset: Offset(1, 4),
                              )
                            ],
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          child: Icon(
                            FontAwesomeIcons.prescriptionBottleMedical,
                            size: 35,
                            color: Colors.white,
                          )),

                      Text('Pharmacy',style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14
                      ),),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context,).push(SwipeablePageRoute(
                        builder: (BuildContext context) => (DoctorPage())));
                  },
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.redAccent.shade100,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.redAccent.shade100.withOpacity(0.4),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset: Offset(1, 4),
                              )
                            ],
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          child: Icon(
                            FontAwesomeIcons.userDoctor,
                            size: 35,
                            color: Colors.white,
                          )),

                      Text('Doctor',style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14
                      ),),
                    ],
                  ),
                ),

              ],
            ),
SizedBox(height: 20,),
          ],
        ),
      ));
}


Widget getImageWidget(String imageUrl) {
  if (imageUrl.isNotEmpty) {
    return Image.network(
      imageUrl,
      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
        // Display a local asset image when the network image is not available
        return Image.asset(
          'assets/imageicon.png', // Replace with your asset image path
          fit: BoxFit.cover,
        );
      },
    );
  } else {
    // Return a placeholder or default image widget
    return Image.asset(
      'assets/imageicon.png', // Replace with your asset image path
      fit: BoxFit.cover,
    );
  }
}
