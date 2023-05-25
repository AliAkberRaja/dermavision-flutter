import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:derma_vision/Drawer_Pages/patientdetailpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';


class Results extends StatefulWidget {
  const Results({Key? key}) : super(key: key);

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('patients');
  final storage = FirebaseStorage.instance;
  File ? image;

  Widget build(BuildContext context) => Container(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Results'),
            centerTitle: true,
            backgroundColor: Colors.teal.shade300,
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                StreamBuilder(
                    stream: ref.onValue,
                    builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                      if (!snapshot.hasData) {
                        return Padding(
                          padding:  EdgeInsets.symmetric(vertical: 200),
                          child: Center(child: CircularProgressIndicator(),),
                        ) ;
                      } else {
                        Map<dynamic, dynamic>? map =
                        snapshot.data!.snapshot.value as dynamic;
                        if (map != null) {
                          List<dynamic> list = [];
                          list.clear();
                          list = map.values.toList();

                          return ListView.builder(
                              physics: ScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemCount: snapshot.data!.snapshot.children
                                  .length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return ResultDisplay(
                                  context,
                                  list[index]['patientname'],
                                  list[index]['DOB'],
                                  list[index]['gender'],
                                  list[index]['dateoftest'],
                                  list[index]['patientage'],
                                  list[index]['reference'],
                                  list[index]['diseasename'],
                                  list[index]['percentage'],
                                  list[index]['condition'],
                                  list[index]['threat'],
                                  list[index]['risk'],
                                  list[index]['diagnosis'],
                                  list[index]['treatment'],
                                  list[index]['advice'],
                                  list[index]['imageurl'],
                                  list[index]['imagename'],
                                );
                              });
                        }
                      else{
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Center(child: Text('No Data Available')),
                          );
                        }
                      }
                    }),
                //add stream builder here
              ],
            ),
          ),
        ),
      );

}

Container ResultDisplay(
  BuildContext context,
  String PatientName,
  String DOB,
  String Gender,
  String DateofTest,
  int Patientage,
  String reference,
  String DiseaseName,
  String Percentage,
  String Condition,
  String Threat,
  String Risk,
  String Diagnosis,
  String Treatment,
  String Advice,
    String ImageUrl,
    String Imagename,
) {
  var randomncolor =
      Colors.primaries[Random().nextInt(Colors.primaries.length)];
  return Container(
    height: MediaQuery.of(context).size.height * 0.20,
    margin: EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 10),
    decoration: BoxDecoration(
      color: randomncolor.shade50,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade600.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 3,
          offset: Offset(0, 2),
        )
      ],
    ),
    child: Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.005,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: randomncolor,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 5,
                        ),
                        child: Icon(
                          Icons.person_sharp,
                          size: 27,
                          color: randomncolor,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 10,
                        ),
                        child: Text(
                          PatientName,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 5,
                        ),
                        child: Icon(
                          Icons.calendar_month_sharp,
                          size: 27,
                          color: randomncolor,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 10,
                        ),
                        child: Text(
                         "DOB: "+ DOB,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 5,
                        ),
                        child: Icon(
                          FontAwesomeIcons.venusMars,
                          size: 22,
                          color: randomncolor,
                        ),
                      ),
                      SizedBox(
                        width: 11,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 10,
                        ),
                        child: Text(
                          Gender,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      showDialog(context: context, builder: (context)=>
                          AlertDialog(
                            title: Text("Are you Sure you want to Delete "+PatientName+"'s record?",style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal),),
                            backgroundColor: randomncolor.shade100,
                            content:

                            Container(
                              height: MediaQuery.of(context).size.height*0.10,
                              width: MediaQuery.of(context).size.width,

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      FirebaseDatabase.instance.ref()
                                          .child('patients')
                                          .child(reference)
                                          .remove();

                                      final _storageRef = FirebaseStorage.instance.ref();
                                      final _imageRef = _storageRef.child('patientdisease/$Imagename');
                                      _imageRef.delete().then((_) {
                                        print('Image deleted successfully from Firebase Storage');
                                      }).catchError((error) {
                                        print('Failed to delete image from Firebase Storage: $error');
                                      });
                                   Navigator.of(context).maybePop();

                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 0),

                                      padding: EdgeInsets.all(15),

                                    
                                      decoration: BoxDecoration(

                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),

                                      child: Text(
                                          'Yes'

                                      ),
                                    ),
                                  ),

                                  SizedBox(width: 5,),
                                  InkWell(
                                    onTap: (){
                                      // _imgFromCamera();
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 0),

                                      padding: EdgeInsets.all(15),


                                      decoration: BoxDecoration(

                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),

                                      child: Text(
                                          'No'
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          )
                      );
                    },
                    child: Container(

                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(5),

                        border: Border.all(width: 1,color: Colors.redAccent.shade100),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(

                            child: Icon(
                              FontAwesomeIcons.trash,
                              size: 18,
                              color: Colors.redAccent,
                            ),
                          ),
                          SizedBox(
                            width: 11,
                          ),
                          Container(

                            child: Text(
                              "Delete",
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 15,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),//Delete
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: FloatingActionButton(
                elevation: null,
                backgroundColor: randomncolor.shade100,
                hoverColor: randomncolor.shade200,
                splashColor: randomncolor.shade200,

                onPressed: () {
                   Navigator.push(
                      context,
                      SwipeablePageRoute(
                          builder: (context) =>
                              PatientDetailPage(
                                PatientName: PatientName,
                                gender: Gender,
                                Age: Patientage,
                                DateofBirth: DOB,
                                DiseaseName: DiseaseName,
                                Percentage: Percentage,
                                diseaseimage: ImageUrl,
                                testdate: DateofTest,
                                Condition: Condition,
                                ThreatLevel: Threat,
                                Risk: Risk,
                                Diagnosis: Diagnosis,
                                Treatment: Treatment,
                                Advice: Advice,
                              )));
                },
                child: Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: randomncolor.shade900,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ],
    ),




  );

}

