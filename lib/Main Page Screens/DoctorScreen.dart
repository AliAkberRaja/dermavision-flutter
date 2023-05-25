import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import '../Drawer_Pages/ViewDoctorDetails.dart';

class DoctorPage extends StatefulWidget {
  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  late String imagePath;
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Doctors');
  final storage = FirebaseStorage.instance;
  String searchQuery="";

  // const Homepage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return initScreen();
  }

  Future<String> getImageUrl(String imagePath) async {
    final ref2 = storage.ref('ImagesDoctor').child(imagePath);
    var url = await ref2.getDownloadURL();
    return url;
  }


  Widget initScreen() {
    //getImageUrl();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
            color: Colors.cyan,
            height: MediaQuery.of(context).size.height / 6,
            child: Column(
              children: [
                const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Doctors',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          color: Colors.white),
                    )), //Doctor
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child:  TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(FontAwesomeIcons.magnifyingGlass),
                          border: InputBorder.none,
                          hintText: 'Search',
                        ),
                        onChanged: (val){
                          setState(() {
                            searchQuery=val;
                          });
                        },
                      ),
                    ),
                  ),
                ) //Search Bar
              ],
            )),
            //below the search bar functionalities
            Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              width: size.width,
              margin: const EdgeInsets.only(top: 5, left: 20, bottom: 5),
              child: Stack(
                fit: StackFit.loose,
                children: [
                  const Text(
                    'Top Rated',
                    style: TextStyle(
                      color: Color(0xff363636),
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  //top rated
                  Container(
                    margin: EdgeInsets.only(right: 20, top: 2, bottom: 5),
                    child: const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'See all',
                        style: TextStyle(
                          color: Color(0xff5e5d5d),
                          fontSize: 13,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                  ) //see all
                ],
              ),
            )),
            Column(
              
          children: [
            StreamBuilder(
              stream: ref.onValue,
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                } else {
                  Map<dynamic, dynamic> map = snapshot.data!.snapshot.value as dynamic;
                  List<dynamic> list = [];
                  list.clear();
                  list = map.values.toList();

                  // Replace 'searchQuery' with the actual search query string
                  String lowercaseQuery = searchQuery.toLowerCase();

                  // Filter the list based on the search query
                  List<dynamic> filteredList = list.where((item) {
                    String doctorName = item['DoctorName'].toString().toLowerCase();
                    String city = item['City'].toString().toLowerCase();
                    String type = item['Specialist'].toString().toLowerCase();
                    String fee = item['Fees'].toString().toLowerCase();
                    return doctorName.contains(lowercaseQuery) || city.contains(lowercaseQuery) || type.contains(lowercaseQuery)|| fee.contains(lowercaseQuery);
                  }).toList();

                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: filteredList.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return DoctorDisplay(
                        context,
                        filteredList[index]['DoctorImage'],
                        filteredList[index]['DoctorName'],
                        filteredList[index]['Specialist'],
                        filteredList[index]['Rating'],
                        filteredList[index]['Experience'],
                        filteredList[index]['Fees'],
                        filteredList[index]['Address'],
                        filteredList[index]['Contact'],
                        filteredList[index]['Longitude'],
                        filteredList[index]['Latitude'],
                        filteredList[index]['City'],
                        filteredList[index]['Timings'],
                      );
                    },
                  );
                }
              },
            )

          ],
            ),
          ]),
        ));
  }
}

Widget DoctorDisplay(
    BuildContext context,
    String Imagepath,
    String DoctorName,
    String type,
    String Rating,
    String Experience,
    String Fee,
    String Address,
    String Contact,
    String Longitude,
    String Latitude,
    String City,
    String Timings) {
  return InkWell(
    onTap: (){

        Navigator.of(context,rootNavigator: true).push(SwipeablePageRoute(
            builder: (BuildContext context) => ViewDoctorDetails(
              Doctorname: DoctorName,
              Doctortype: type,
              DoctorExperience: Experience,
              DoctorFee: Fee,
              DoctorImg: Imagepath,
              DoctorRating: Rating,
              DocAddress: Address,
              DocContact: Contact,
              DocLongitude: Longitude,
              DocLatitude: Latitude,
              DocTimings: Timings,
              Doccity: City,
            )));
    },
    child: Container(
        height: 200,
        margin: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 15),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20, top: 20),
                  height: 80,
                  width: 80,
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage(Imagepath),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, top: 10),
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
                                  Text(
                                    Experience,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                  const Text(
                                    ' years',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Roboto',
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
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10),
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
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    height: 45,
                    width: 210,
                    decoration: BoxDecoration(
                      color: Colors.deepOrange.shade300,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepOrange.shade200.withOpacity(0.6),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(1, 4),
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
                ],
              ),
            ),
          ],
        )),
  );
}
