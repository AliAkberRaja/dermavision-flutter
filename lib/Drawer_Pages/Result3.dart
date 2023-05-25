import 'dart:io';
import 'package:derma_vision/Drawer_Pages/PharmacyScreen.dart';
import 'package:derma_vision/Main%20Page%20Screens/DoctorScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

class  Results3 extends StatefulWidget {
  File? imagefile;
  String results;
  String confidence;
  String Diseasename;
  String Diseasecondition;
  String Diseasetreatment;
  String Diseaserisk;
  String Diseaseadvice;
  String Diseasediagnosis;
  String Diseasethreat;
  Results3 ({Key? key,
    required this.imagefile,
    required this.results,
    required this.Diseasename,
    required this.confidence,
    required this.Diseasecondition,
    required this.Diseasetreatment,
    required this.Diseaserisk,
    required this.Diseaseadvice,
    required this.Diseasediagnosis,
    required this.Diseasethreat,



  }) : super(key: key);

  @override
  State<Results3> createState() => _Results3State();
}

class _Results3State extends State<Results3> {
  String diseaseValue = '';

  // Future<String> getDiseaseValue() async {
  //   DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  //
  //   try {
  //     DataSnapshot snapshot = (await _dbRef.child(Diseasename).once()) as DataSnapshot;
  //     if (snapshot.value != null) {
  //       String value = snapshot.value.toString();
  //       print(value);
  //       return value;
  //     } else {
  //       return "No data found in the Disease folder";
  //     }
  //   } catch (error) {
  //     return "Error: $error";
  //   }
  // }

  @override
  void initState() {
    super.initState();
    //fetchData();
  }

  // void fetchData() async {
  //   String value = await getDiseaseValue();
  //   setState(() {
  //     diseaseValue = value;
  //   });
  // }




  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar:AppBar(
          title:Text('Disease Result'),
          backgroundColor: Colors.cyan,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              child:Column(
                children: [



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
                          child: widget.imagefile != null ? Image.file(widget.imagefile!,)
                              : Container(

                            child: const Icon(
                              FontAwesomeIcons.bacteria,
                              color: Colors.black,
                              size: 50,
                            ),
                          ),
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
                      Text(widget.Diseasename),
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
                      Text(widget.Diseasecondition),
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
                      Text(widget.Diseasethreat),
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
                      Text(widget.confidence.toString()+"%"),
                    ],

                  ),
                  const Divider(
                    height: 10,
                    indent: 20.0,
                    endIndent: 20.0,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10,),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.4,

                    decoration: BoxDecoration(
                        color: Colors.cyan.shade50,
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

                            child: Text(widget.Diseaserisk)),
                        Row(


                          children: [
                            SizedBox(width: 5,),
                            Icon(FontAwesomeIcons.notesMedical,color:  Colors.lightBlueAccent.shade700,size: 18,),
                            SizedBox(width: 10,),
                            Text('Conclusion :',style: TextStyle(fontWeight: FontWeight.w500),),
                            SizedBox(width: 10,),
                            Text(widget.confidence.toString() + "%  " + widget.Diseasename,style: TextStyle(fontWeight: FontWeight.w400),),
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

                            child: Text(widget.Diseasediagnosis)),
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

                            child: Text(widget.Diseasetreatment)),
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

                            child: Text(widget.Diseaseadvice)),


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
                ],
              )
          ),
        )
    );
    //return const Placeholder();
  }
}
