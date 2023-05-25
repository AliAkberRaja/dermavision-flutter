import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:derma_vision/Drawer_Pages/Aboutus.dart';
import 'package:derma_vision/Drawer_Pages/_selectimage.dart';
import 'package:derma_vision/Drawer_Pages/results.dart';
import 'package:derma_vision/Drawer_Pages/settings_user.dart';
import 'package:derma_vision/Drawer_Pages/terms_and_conditions.dart';
import 'package:derma_vision/Main%20Page%20Screens/dashboard.dart';
import 'package:derma_vision/Login%20Screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Drawer_Pages/home.dart';
import '../Drawer_Pages/profile.dart';
import '../Drawer_Pages/user_page.dart';
import '../utils/color_utils.dart';
import 'DoctorScreen.dart';

class NavigationDrawerWidget extends StatefulWidget {
  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;
String email="";
String myUsername="User";
String myUrlAvatar = '';
String useruid='';





class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  void fetchUserDetails() async {
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



  @override
  Widget build(BuildContext context) {
  //  final name = 'Ali Akbar';
   // final email = 'aliakberraja@gmail.com';
   // final urlImage = 'https://aliakberraja.github.io/profile/images/ali.jpg';
    return Drawer(
        child: SafeArea(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("FFA372"),
          hexStringToColor("00BCD4")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: ListView(
          padding: padding,
          children: <Widget>[
            buildHeader(
                urlImage: myUrlAvatar,
                name: myUsername,
                email: email,
                onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UserPage(
                        name: myUsername,
                        urlImage: myUrlAvatar,
                      ),
                    ))),
            Divider(color: Colors.white70, thickness: 1.0),
            SizedBox(height: 16),
            buildMenuItem(
              text: 'Home',
              icon: FontAwesomeIcons.home,
              onClicked: () => selectedItem(context, 0),
            ),
            SizedBox(height: 16),
            buildMenuItem(
              text: 'Profile',
              icon: FontAwesomeIcons.solidUser,
              onClicked: () => selectedItem(context, 1),
            ),
            SizedBox(height: 16),
            buildMenuItem(
              text: 'Settings',
              icon: FontAwesomeIcons.gear,
              onClicked: () => selectedItem(context, 2),
            ),
            SizedBox(height: 16),
            buildMenuItem(
              text: 'Results',
              icon: FontAwesomeIcons.fileContract,
              onClicked: () => selectedItem(context, 3),
            ),
            // SizedBox(height: 16),
            // buildMenuItem(
            //   text:'Doctor',
            //   icon: FontAwesomeIcons.briefcaseMedical,
            //   onClicked: ()=>selectedItem(context,4),
            // ),

            SizedBox(height: 16),
            Divider(
              color: Colors.white70,
              thickness: 1.0,
            ),
            SizedBox(height: 16),

            buildMenuItem(
              text: 'Terms and Conditions',
              icon: FontAwesomeIcons.fileContract,
              onClicked: () => selectedItem(context, 4),
            ),
            SizedBox(height: 16),
            buildMenuItem(
              text: 'About Us',
              icon: FontAwesomeIcons.circleQuestion,
              onClicked: () => selectedItem(context, 5),
            ),
            SizedBox(height: 16),
            buildMenuItem(
              text: 'Logout',
              icon: FontAwesomeIcons.rightFromBracket,
              onClicked: () => selectedItem(context, 6),
            ),
          ],
        ),
      ),
    ));
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text,
          style: TextStyle(
              color: color, fontSize: 15, fontWeight: FontWeight.w400)),
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Dashboard(),
            settings: RouteSettings(name: '/homepage')));

        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SelectImage(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SettingsPage(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Results(),
        ));
        break;

      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => TermsandConditions(),
        ));

        break;
      case 5:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AboutUs(),
        ));
        break;
      case 6:
        FirebaseAuth.instance.signOut().then((value) {
          print("Signed out");
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MyLogin(),
          ));
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Logged out Successfully!'),
          backgroundColor: Colors.deepOrangeAccent.shade100,
        ));
        break;
    }
  }

  buildHeader(
          {required String urlImage,
          required String name,
          required String email,
          required VoidCallback onClicked}) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(const EdgeInsets.symmetric(vertical: 30)),
          child: Row(
            children: [
              ClipOval(
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: hexStringToColor("00BCD4"),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/male.jpg',
                    image: urlImage,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    imageErrorBuilder: (context, error, stackTrace) {
                      // Fallback to asset image if network image fails to load
                      return Image.asset(
                        'assets/male.jpg',
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),


              SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    email,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  )
                ],
              )
            ],
          ),
        ),
      );
}
