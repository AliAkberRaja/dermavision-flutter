
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';




enum Gender { Male, Female }

class PharmacyDetailsPage extends StatelessWidget {
   final String Pharname;
  final String PharImg;
   final String PharAddress;
   final String PharRating;
  final String PharContact;
  final String Latitude;
   final String Longitude;
  final String Pharcity;
  final String PharTimings;


  const PharmacyDetailsPage({Key? key,
    required this.Pharname,
    required this.PharImg,
    required this.PharAddress,
    required this.PharRating,
    required this.PharContact,
    required this.Latitude,
    required this.Longitude,
    required this.Pharcity,
    required this.PharTimings,
  }
      )
      : super(key: key);

   static Future<void> openMap(double latitude, double longitude) async {
     String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
     if (await canLaunch(googleUrl)) {
       await launch(googleUrl);
     } else {
       throw 'Could not open the map.';
     }
   }
   // static final CameraPosition _kGooglePlex =
   // CameraPosition(target: LatLng(33.6844, 73.0479), zoom: 14);

  Widget build(BuildContext context) => Scaffold(
    resizeToAvoidBottomInset: false,
    appBar: AppBar(
      title: Text(Pharname),
      centerTitle: true,
      backgroundColor:Colors.cyan.shade500,
      elevation: 0.0,

    ),
    body: SingleChildScrollView(
      child: Column(
        children: [


          Container(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.30,
              decoration: BoxDecoration(
                color: Colors.cyan.shade100,
boxShadow: [ BoxShadow(
  color: Colors.grey.shade400.withOpacity(0.4),
  spreadRadius: 4,
  blurRadius: 6,
  offset: Offset(1, 3),
)
],
borderRadius: BorderRadius.only(bottomRight: Radius.circular(240)),
                image: DecorationImage(
                  image: NetworkImage(PharImg),
                  fit: BoxFit.fitWidth,
                ),
              ),
          ),
    Container(
      margin: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
      width: double.maxFinite,
      child: Column(

        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Text(
                  Pharname,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700
                  ),

          ),
               Container(

                   padding: EdgeInsets.all(4),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(7),
                     color: Colors.white,
                     boxShadow: [
                       BoxShadow(
                         color: Colors.grey.shade400.withOpacity(0.4),
                         spreadRadius: 4,
                         blurRadius: 4,
                         offset: Offset(1, 2),
                       )
                     ],
                   ),
                   child: Row(
                     children: [

                       Text(
                         PharRating,
                         style: TextStyle(
                           color: Colors.black,
                           fontSize: 15,
                           fontWeight: FontWeight.w500,

                         ),
                       ),
                       SizedBox(width: 2,),
                       Icon(
                         Icons.star,
                         size: 16,
                         color: Colors.yellow.shade700,

                       ),
                     ],
                   )),
             ],
           ),
          SizedBox(height: 5,),
          Text(
            'Pharmacy',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black54
            ),
          ),
          SizedBox(height: 10,),
          Text(
            Pharcity,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black54
            ),
          ),
          SizedBox(height: 10,),
          Text(
            PharAddress,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w100,
                color: Colors.black54
            ),
          ),
        ],
      ),
    ),




          Container(

            margin: EdgeInsets.only(left: 20,right: 20,bottom: 10),
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.08,
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
            child: Container(
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15,top: 10),
                        child: Text(
                          "Timings",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,

                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15,top: 10),
                        child: Row(
                          children: [
                            Icon(Icons.access_time,size: 23, color: Colors.cyan.shade700,),
                            SizedBox(width: 7,),
                            Text(
                              PharTimings,
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
          ),

          Container(

            margin: EdgeInsets.only(left: 20,right: 20,top: 10),
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.04,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(7),topRight: Radius.circular(7)),
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
            child:  Text(
            "Location",style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          ),
          ),

          Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 0),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.10,
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
                    width: MediaQuery.of(context).size.width * 0.705,
                    height: MediaQuery.of(context).size.height * 0.10,
                    child:
                    GoogleMap(
                      initialCameraPosition: CameraPosition(target: LatLng(double.parse(Latitude),double.parse(Longitude),),zoom: 14),
                      zoomControlsEnabled: false,
                    ),

                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.19,
                    height: MediaQuery.of(context).size.height * 0.10,
                    child: GestureDetector(
                      onTap: () {
                        openMap(double.parse(Latitude),double.parse(Longitude));
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
            margin: EdgeInsets.only(left: 20,right: 20,top: 20),
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.08,


            child: GestureDetector(
              onTap: ()
              {
                launch('tel:'+PharContact);
              },
              child: Container(
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
                padding: EdgeInsets.symmetric(horizontal:30,vertical: 15),
                child: Icon(
                  FontAwesomeIcons.phone,size: 35,
                  color: Colors.white,
                ),),
            ),
          ),
          SizedBox(height: 20,),

        ],
      ),
    ),
    //drawer: NavigationDrawerWidget(),
    // floatingActionButton: Padding(
    //   padding: const EdgeInsets.only(bottom: 560,right: 310),
    //   child: FloatingActionButton(
    //     elevation: 0,
    //     backgroundColor: Colors.transparent,
    //     splashColor: Colors.white70,
    //     shape: ContinuousRectangleBorder(
    //         borderRadius: BorderRadius.circular(30), side: BorderSide.none),
    //     onPressed: () {
    //       Navigator.of(context).pop();
    //
    //       // Navigator.of(context).pushAndRemoveUntil(
    //       //     MaterialPageRoute(builder: (context) => DoctorPage()),
    //       //     (Route<dynamic> route) => false);
    //     },
    //     child: Container(
    //       height: 35,
    //       width: 35,
    //       decoration: BoxDecoration(
    //         color: Colors.white70,
    //         border: Border.all(width: 1.4, color: Colors.black26),
    //         borderRadius: BorderRadius.circular(10),
    //       ),
    //       child: const Icon(
    //         Icons.arrow_back_ios_rounded,
    //         color: Colors.cyan,
    //         size: 15,
    //       ),
    //     ),
    //   ),
    // ),


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
