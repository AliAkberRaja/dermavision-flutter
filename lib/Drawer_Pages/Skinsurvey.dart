import 'package:flutter/material.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

import 'SkinSurveyForm.dart';

class SkinSurvey extends StatelessWidget {
  const SkinSurvey({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Container(
          child:  Scaffold(
              appBar: AppBar(
                title: Text('Skin Survey'),
                centerTitle: true,
                backgroundColor: Colors.deepPurple.shade300,

                leadingWidth: 50,
              ),
              body: SingleChildScrollView(
                child: Column(

                  children: [
                    SizedBox(height: 20,),
                    Center(
                      child: Container(

                        width: MediaQuery.of(context).size.width*0.9,
                        height:MediaQuery.of(context).size.height*0.32,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.deepPurple.shade50,

                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.8,
                          height:MediaQuery.of(context).size.height*0.32,
                          child: Image(
                            image: AssetImage("assets/skinsurvey.jpg"),
                            alignment: Alignment.center,




                          ),
                        )
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: MediaQuery.of(context).size.width*0.9,
                      alignment: Alignment.topLeft,
                      child: Text('Skin Symptoms Checker',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                    SizedBox(height: 10,),
                    Container(

                      height: 170,
                      width: MediaQuery.of(context).size.width*0.9,
                      child: Text(
                        "DermaVision offers a skin symptom checker primarily for skin disease patients. Based on the entered symptoms it tells the patient what possible skin diseases they have. It directs them to more medical information and shows the right doctor for further clarifications. ",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height*0.08,
                      width: MediaQuery.of(context).size.width*0.9,

                      child: ElevatedButton(onPressed: (){
                        Navigator.of(context,rootNavigator: true).push(
                            SwipeablePageRoute(builder: (context) => SkinSurveyForm()));
                      },style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple.shade300),

                      ),
                      child: Text(
                        "Start your Survey"
                            ,style: TextStyle(
                        fontSize: 18
                      ),

                      ),)
                    )
                  ],
                ),
              )

          ),
      );
}

