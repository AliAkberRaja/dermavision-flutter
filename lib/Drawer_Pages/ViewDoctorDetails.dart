import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


enum Gender { Male, Female }

class ViewDoctorDetails extends StatelessWidget {
  final String Doctorname;
  final String DoctorImg;
  final String Doctortype;
  final String DoctorRating;
  final String DoctorExperience;
  final String DoctorFee;
  final String DocAddress;
  final String DocContact;
  final String DocLongitude;
  final String DocLatitude;
  final String Doccity;
  final String DocTimings;



  // static final CameraPosition _kGooglePlex =
  //     CameraPosition(target: LatLng(33.6844, 73.0479), zoom: 14);

  const ViewDoctorDetails(
      {Key? key,
      required this.Doctorname,
      required this.DoctorImg,
      required this.Doctortype,
      required this.DoctorRating,
      required this.DoctorExperience,
      required this.DoctorFee,
      required this.DocLongitude,
        required this.DocLatitude,
      required this.DocAddress,
      required this.DocContact,
      required this.Doccity,
      required this.DocTimings})
      : super(key: key);

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }



  @override
  Widget build(BuildContext context) => Scaffold(
    resizeToAvoidBottomInset: false,
    appBar: AppBar(
      title: Text(Doctorname),
      centerTitle: true,
      backgroundColor:Colors.teal.shade300,
      elevation: 0.0,

    ),
    body: SingleChildScrollView(
      child: Column(
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   crossAxisAlignment: CrossAxisAlignment.end,
          //   children: [
          //     FloatingActionButton(
          //       elevation: 0,
          //       heroTag: null,
          //       backgroundColor: Colors.transparent,
          //       splashColor: Colors.white70,
          //       shape: ContinuousRectangleBorder(
          //           borderRadius: BorderRadius.circular(30),
          //           side: BorderSide.none),
          //       onPressed: () {
          //         Navigator.of(context).pop();
          //
          //         // Navigator.of(context).pushAndRemoveUntil(
          //         //     MaterialPageRoute(builder: (context) => DoctorPage()),
          //         //     (Route<dynamic> route) => false);
          //       },
          //       child: Container(
          //         height: 35,
          //         width: 35,
          //         decoration: BoxDecoration(
          //           color: Colors.white70,
          //           border: Border.all(width: 1.4, color: Colors.black26),
          //           borderRadius: BorderRadius.circular(10),
          //         ),
          //         child: const Icon(
          //           Icons.arrow_back_ios_rounded,
          //           color: Colors.cyan,
          //           size: 15,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          Container(
            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.20,
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.40,
                  height: MediaQuery.of(context).size.height * 0.20,
                  decoration: BoxDecoration(
                    color: Colors.cyan.shade100,
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    image: DecorationImage(
                      image: NetworkImage(DoctorImg),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 20, top: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Doctorname,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          Doctortype,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          Doccity,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          ('Address:  ' + DocAddress),
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w200,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.10,
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.40,
                  height: MediaQuery.of(context).size.height * 0.10,
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color:
                                    Colors.grey.shade400.withOpacity(0.4),
                                spreadRadius: 4,
                                blurRadius: 4,
                                offset: Offset(1, 2),
                              )
                            ],
                          ),
                          child: Icon(
                            Icons.star,
                            size: 23,
                            color: Colors.orangeAccent.shade700,
                          )),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 15, top: 20),
                            child: Text(
                              DoctorRating,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 15, top: 2),
                            child: Text(
                              "Ratings",
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.40,
                  height: MediaQuery.of(context).size.height * 0.10,
                  margin: EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color:
                                    Colors.grey.shade400.withOpacity(0.4),
                                spreadRadius: 4,
                                blurRadius: 4,
                                offset: Offset(1, 2),
                              )
                            ],
                          ),
                          child: Icon(
                            FontAwesomeIcons.stethoscope,
                            size: 23,
                            color: Colors.cyan.shade700,
                          )),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 15, top: 20),
                            child: Text(
                              DoctorExperience,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 15, top: 2),
                            child: Text(
                              "Experience",
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin:
            EdgeInsets.only(left: 20, right: 20,),
            alignment: Alignment.topLeft,
            child: Text(
              "Location",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 10),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.17,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.transparent,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400.withOpacity(0.4),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(1, 4),
                  )
                ],

              ),
              child:
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.17,
                    child:
                    GoogleMap(
                      initialCameraPosition: CameraPosition(target: LatLng(double.parse(DocLatitude),double.parse(DocLongitude)),zoom: 16),
                      zoomControlsEnabled: false,
                    ),

                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.19,
                    height: MediaQuery.of(context).size.height * 0.17,
                    child: GestureDetector(
                      onTap: () {
                        openMap(double.parse(DocLatitude), double.parse(DocLongitude));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          color: Colors.blue.shade400,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.shade100
                                  .withOpacity(0.4),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(1, 4),
                            )
                          ],
                        ),
                        child: Icon(
                          Icons.fmd_good_outlined,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),

                  ),
                ],
              )


          ),
          Container(
            margin:
            EdgeInsets.only(left: 20, right: 20,top: 20),
            alignment: Alignment.topLeft,
            child: Text(
              "Details",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 0,top: 10),
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400.withOpacity(0.4),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(1, 4),
                )
              ],
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.890,
              height: MediaQuery.of(context).size.height * 0.10,
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15, top: 20),
                        child: Text(
                          "Fee",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15, top: 12),
                        child: Row(
                          children: [
                            Text(
                              'Rs. ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              DoctorFee,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 15, top: 20),
                              child: Text(
                                "Availability",
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15, top: 10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 20,
                                    color: Colors.grey.shade700,
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Text(
                                    DocTimings,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),







          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 50),
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.08,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    launch('tel:' + DocContact);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.greenAccent.shade100
                              .withOpacity(0.4),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(1, 4),
                        )
                      ],
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    child: Icon(
                      FontAwesomeIcons.phone,
                      size: 35,
                      color: Colors.lightGreen.shade600,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    launch('sms:' +
                        DocContact +
                        '?body=Hi, I would like to book an Appointment. Can you share available slots?');
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.blue.shade100,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.shade100.withOpacity(0.4),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(1, 4),
                          )
                        ],
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      child: Icon(
                        Icons.sms_rounded,
                        size: 35,
                        color: Colors.lightBlue.shade600,
                      )),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    launch('https://wa.me/' + DocContact);
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.green.shade400,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.shade400.withOpacity(0.4),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(1, 4),
                          )
                        ],
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      child: Icon(
                        FontAwesomeIcons.whatsapp,
                        size: 35,
                        color: Colors.white,
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    ),
    //drawer: NavigationDrawerWidget(),
  );

  // Future chooseOption() => showDialog(context: context, builder: (context)=>
  //     AlertDialog(
  //       title: Text("Choose:"),
  //       backgroundColor: Colors.cyan.shade100,
  //       content:
  //
  //       Container(
  //         height: MediaQuery.of(context).size.height*0.19,
  //         width: MediaQuery.of(context).size.width,
  //
  //         child: Column(
  //           children: [
  //             InkWell(
  //               onTap: (){
  //                 Navigator.of(context).maybePop();
  //               },
  //               child: Container(
  //                 margin: EdgeInsets.only(top: 20),
  //                 width: MediaQuery.of(context).size.width,
  //                 padding: EdgeInsets.only(top: 20,bottom: 20),
  //
  //                 alignment: Alignment.center,
  //                 decoration: BoxDecoration(
  //
  //                   color: Colors.grey.shade100,
  //                   borderRadius: BorderRadius.circular(15.0),
  //                 ),
  //
  //                 child: Text(
  //                     'Take Image from Camera'
  //                 ),
  //               ),
  //             ),
  //             SizedBox(height: 10,),
  //             InkWell(
  //               onTap: () async {
  //
  //                 Navigator.of(context).maybePop();
  //               },
  //               child: Container(
  //                 width: MediaQuery.of(context).size.width,
  //                 padding: EdgeInsets.only(top: 20,bottom: 20),
  //                 alignment: Alignment.center,
  //                 decoration: BoxDecoration(
  //                   color: Colors.grey.shade100,
  //                   borderRadius: BorderRadius.circular(15.0),
  //                 ),
  //                 child: Text(
  //                     'Select from Gallery'
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       actions: [
  //         Container(
  //             margin: EdgeInsets.all(0.0),
  //             padding: EdgeInsets.all(0.0),
  //             child:
  //             CloseButton(
  //
  //             )
  //         )
  //
  //       ]
  //       ,
  //
  //
  //     )
  // );


}

class MapUtils {

  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}