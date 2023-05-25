import 'package:derma_vision/Drawer_Pages/PharmacyDetailsPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

class PharmacyPage extends StatefulWidget {
  @override
  State<PharmacyPage> createState() => _PharmacyPageState();
}

class _PharmacyPageState extends State<PharmacyPage> {
  // const Homepage({Key? key}) : super(key: key);
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Pharmacy');
  final storage = FirebaseStorage.instance;
  String searchquery="";
  @override
  Widget build(BuildContext context) {
    return initScreen();
  }

  Widget initScreen() {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            child: Container(
                child: Column(children: [
          Container(
              color: Colors.cyan,
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  Container(
                    child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          'Locate Pharmacies',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'Roboto',
                              color: Colors.white),
                        )),
                  ), //Doctor
                  Container(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextField(
                          decoration: InputDecoration(

                            prefixIcon: Icon(FontAwesomeIcons.magnifyingGlass),
                            border: InputBorder.none,
                            hintText: 'Search',
                          ),
                          onChanged: (val)
                          {
                            setState(() {
                              searchquery = val;
                            });
                          },
                        ),
                      ),
                    ),
                  )) //Search Bar
                ],
              )),
          //below the search bar functionalities
          Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                width: size.width,
                margin: EdgeInsets.only(top: 5, left: 20),
                child: Stack(
                  fit: StackFit.loose,
                  children: [
                    Container(
                      child: const Text(
                        'Nearest ',
                        style: TextStyle(
                          color: Color(0xff363636),
                          fontSize: 20,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ), //top rated
                    Container(
                      margin: EdgeInsets.only(right: 20, top: 1),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'See all',
                          style: TextStyle(
                            color: Color(0xff5e5d5d),
                            fontSize: 19,
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
                    Map<dynamic, dynamic> map =
                    snapshot.data!.snapshot.value as dynamic;
                    List<dynamic> list = [];
                    list.clear();
                    list = map.values.toList();

                    // Replace 'searchQuery' with the actual search query string
                    String lowercaseQuery = searchquery.toLowerCase();

                    // Filter the list based on the search query
                    List<dynamic> filteredList = list.where((item) {
                      String pharmacyName = item['PharmacyName'].toString().toLowerCase();
                      String city = item['City'].toString().toLowerCase();
                      return pharmacyName.contains(lowercaseQuery) || city.contains(lowercaseQuery);
                    }).toList();

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: filteredList.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        return PharmacyDisplay(
                          context,
                          filteredList[index]['PharmacyImage'],
                          filteredList[index]['PharmacyName'],
                          filteredList[index]['Timings'],
                          filteredList[index]['Rating'],
                          filteredList[index]['City'],
                          filteredList[index]['Address'],
                          filteredList[index]['Latitude'],
                          filteredList[index]['Longitude'],
                          filteredList[index]['Contact'],
                        );
                      },
                    );
                  }
                },
              )


              //add stream builder here
            ],
          ),
        ]))));
  }
}

Widget PharmacyDisplay(
  BuildContext context,
  String Imagepath,
  String PharmacyName,
  String timings,
  String Rating,
  String city,
    String Address,
    String Latitude,
    String Longitude,
    String Contact
) {
  return InkWell(
    onTap: ()
    {
      Navigator.of(context,rootNavigator: true).push(SwipeablePageRoute(
          builder: (BuildContext context) => (PharmacyDetailsPage(
           Pharname: PharmacyName,
         PharImg: Imagepath,
           PharAddress: Address,
         PharRating: Rating,
        PharContact: Contact,
         Latitude: Latitude,
          Longitude: Longitude,
          Pharcity: city,
           PharTimings: timings


          )

          )));
    },
    child: Container(
      height: 140,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.cyan.shade50,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade500.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            height: 120,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade400,
                image: DecorationImage(
                  image: NetworkImage(Imagepath),
                )),
          ),
          Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 15,
                ),
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
              SizedBox(height: 5,),
              RichText(

                text: TextSpan(

                  children: [

                    WidgetSpan(
                      child: Icon(Icons.access_time_outlined, size: 15,color: Colors.redAccent.shade100,),
                    ),

                    TextSpan(
                      text: timings,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5,),
              RichText(
                text: TextSpan(
                  children: [

                    WidgetSpan(
                      child: Icon(Icons.location_on_outlined, size: 15,color: Colors.lightBlue.shade400,),
                    ),
                    TextSpan(
                      text: city,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                height: 35,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.red.shade200,
                  borderRadius: BorderRadius.circular(15),
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
          Column(

            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
    margin: EdgeInsets.only(top: 20,left: 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.cyan.shade400,
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 10),
      child: Text(
        Rating,
        style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
        ),
      ),

    ),),
            ],
          ),
        ],
      ),
    ),
  );
}


