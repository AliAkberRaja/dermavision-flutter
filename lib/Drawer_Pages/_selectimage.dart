import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:derma_vision/Drawer_Pages/Result3.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart' show rootBundle;

enum Gender { Male, Female }

class SelectImage extends StatefulWidget {
  @override
  State<SelectImage> createState() => _SelectImageState();
}

class _SelectImageState extends State<SelectImage> {
  @override
  void initState() {
    // implement initState
    super.initState();
    imagePicker = ImagePicker();
    dateInput.text = "";
    loadAsset();
    // initialize labeler
    createLabeler();

    //  doImageLabeling();
  }


  DatabaseReference ref = FirebaseDatabase.instance.ref("patients/");
  DatabaseReference firebasediseaseref = FirebaseDatabase.instance.ref();
  final storageRef = FirebaseStorage.instance.ref();
  late ImagePicker imagePicker;
  File? images;
  String result = '';
  String diseasename = '';
  String confidencelevel = '';
  int patientage = 0;
  TextEditingController patientname = TextEditingController();
  String patientgender = "";
  TextEditingController dateInput = TextEditingController();
  bool loading = false;
  bool _viewresultbutton = false;
  bool _confirmbuttonvisibli = true;
  String textfield1 = "";
  String textfield2 = "";
  String textfield3 = "";
  String currentdate = "";
  String diseasecondition = "";
  String diseasetreatment = "";
  String diseaserisk = "";
  String diseaseadvice = "";
  String diseasediagnosis = "";
  String diseasethreat = "";
  String imageUrl = "";
  //List _disease = [];
  Disease? diseasefromjson;
  String detecteddisease = "";
  String diseasenamepat="";
  late var catalogdata;

  // declare ImageLabeler
  dynamic imageLabeler;

  // capture image using camera
  _imgFromCamera() async {
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    images = File(pickedFile!.path);
    setState(() {
      images;
      doImageLabeling();
    });
  }

  // choose image using gallery
  _imgFromGallery() async {
    XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        images = File(pickedFile.path);
        doImageLabeling();
      });
    }
  }

  //creating image labeler
  createLabeler() async {
    final modelPath = await _getModel('assets/ml/efficientnet_lite0(1).tflite');
    final options = LocalLabelerOptions(modelPath: modelPath);
    imageLabeler = ImageLabeler(options: options);
  }

  Future<String> _getModel(String assetPath) async {
    if (Platform.isAndroid) {
      return 'flutter_assets/$assetPath';
    }
    final path = '${(await getApplicationSupportDirectory()).path}/$assetPath';
    await Directory(Path.dirname(path)).create(recursive: true);
    final file = File(path);
    if (!await file.exists()) {
      final byteData = await rootBundle.load(assetPath);
      await file.writeAsBytes(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    }
    return file.path;
  }

  //image labeling code here
  doImageLabeling() async {
    result = "";
    final inputImage = InputImage.fromFile(images!);
    final List<ImageLabel> labels = await imageLabeler.processImage(inputImage);
    if (labels.isNotEmpty) {
      final ImageLabel firstLabel = labels.first;
      final String text = firstLabel.label;
      final double confidence = firstLabel.confidence;
      final percentage = double.parse((confidence * 100).toStringAsFixed(2));
      diseasename = text;
      confidencelevel = percentage.toString();
      detecteddisease = firstLabel.label;
      result += "$text   ${confidence.toStringAsFixed(2)}\n";

      setState(() {
        result;
        diseasename;
      });
    }
  }

  // Future<void> fetchData() async {
  //   final snapshot =
  //       await firebasediseaseref.child('Disease/$diseasename').get();
  //   if (snapshot.exists) {
  //     final data = snapshot.value;
  //     print(data);
  //     diseasecondition = snapshot.child('Condition').value.toString();
  //   } else {
  //     print('No data available.');
  //   }
  // }

  // Future<String> loadData() async {
  //   var data = await rootBundle.loadString("assets/disease.json");
  //    setState(() {
  //   catalogdata = json.decode(data);
  //    });
  //   return "success";
  // }

  Future<Map<String, dynamic>> loadAsset() async {
    String jsonData = await rootBundle.loadString('assets/disease.json');
    return jsonDecode(jsonData);

  }

// Function to get the disease details by name
  dynamic getDiseaseDetails(String diseaseName, Map<String, dynamic> diseaseData) {
    if (diseaseData.containsKey(diseaseName)) {
      List<dynamic> diseases = diseaseData[diseaseName];
      if (diseases.isNotEmpty) {
        return diseases[0];
      }
    }
    return null;
  }





  Widget build(BuildContext context) => Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text("New Patient"),
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.cyan.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.10,
                      width: MediaQuery.of(context).size.width * 0.30,
                      decoration: BoxDecoration(
                        color: Colors.cyan.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: images != null
                          ? Image.file(
                              images!,
                              width: 30,
                              height: 30,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/imageicon.png',
                              scale: 4,
                            ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        chooseOption();
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10, top: 42, bottom: 42),
                        height: MediaQuery.of(context).size.height * 0.12,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.cyan.shade200,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.cyan.shade200,
                              offset: const Offset(
                                5.0,
                                5.0,
                              ),
                              blurRadius: 3.0,
                              spreadRadius: 0.05,
                            ), //BoxShadow
                            BoxShadow(
                              color: Colors.white,
                              offset: const Offset(0.0, 0.0),
                              blurRadius: 5.0,
                              spreadRadius: 0.0,
                            ), //BoxShadow
                          ],
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.zero,
                          child: Text(
                            "Take Image",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: loading
                    ? Center(child: CircularProgressIndicator())
                    : Visibility(
                        visible: _confirmbuttonvisibli,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (images?.existsSync() == null) {
                              setState(() {
                                loading = false;
                              });
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Please Select an Image!'),
                                backgroundColor:
                                    Colors.deepOrangeAccent.shade200,
                              ));
                            } else if (images?.existsSync != null)
                            // return null if the text is valid
                            {
                              setState(() {
                                loading = true;
                              }); //Loader

                              print(diseasename);

                              // DatabaseReference patientref = FirebaseDatabase.instance.ref("patientfetch/");
                              // String? newKey = patientref.push().key;
                              // await patientref.child(newKey!).set({
                              //   "diseasene": diseasename,
                              //   "confidence": confidencelevel,
                              // });
                              // //getting patient name
                              //
                              //
                              // final ref = FirebaseDatabase.instance.ref();
                              // final snapshot = await ref.child('patientfetch/$newKey').get();
                              // if (snapshot.exists) {
                              //   diseasenamepat= snapshot.child('diseasene').value.toString()?? "";
                              //   print(diseasenamepat!);
                              //   print("from database");
                              // } else {
                              //   print('No data available.');
                              // }

                              //getting diseasename

                              // String jsonData = await catalogdata;
                              // print(jsonData);
                              // String diseaseName = diseasenamepat!;


                              Map<String, dynamic> diseaseData = await loadAsset();

                              dynamic details = getDiseaseDetails(diseasename, diseaseData);
                              if (details != null) {


                                diseasecondition = details['Condition'];
                                diseaserisk = details['Risk'];
                                diseasethreat = details['Threat'];
                                diseaseadvice = details['Advice'];
                                diseasediagnosis = details['Diagnosis'];
                                diseasetreatment = details['Treatment'];

                                print(details['Risk']);
                                print(details['Condition']);
                                print(details['Threat']);
                                print(details['Advice']);
                                print(details['Diagnosis']);
                                print(details['Name']);
                                print(details['Treatment']);
                              } else {
                                print('Disease not found');
                              }






//saving patient name



                              // List<dynamic> diseases = jsonDecode(jsonData)['Melanoma'];
                              // print(diseases);



                              // final diseasesnapshot3 = await firebasediseaseref
                              //     .child('Disease').child(diseasenamepat)
                              //     .get();

                              // final event = await ref.once(DatabaseEventType.value);
                              // final username = event.snapshot.value?.username ?? 'Anonymous';
                              //
                              //
                              // if (diseasesnapshot3.exists) {
                              //   diseasecondition= diseasesnapshot3.child('Condition').value.toString();
                              //   print(diseasecondition);
                              //   print("from database");
                              // } else {
                              //   print('No data available.');
                              // }
                              //



                              // if (dataSnapshot.value != null) {
                              //   var diseaseData = dataSnapshot.value
                              //       as Map<dynamic, dynamic>?;
                              //
                              //   if (diseaseData != null) {
                              //     diseasecondition =
                              //         diseaseData['Condition']?.toString() ??
                              //             '';
                              //     diseasetreatment =
                              //         diseaseData['Treatment']?.toString() ??
                              //             '';
                              //     diseaserisk =
                              //         diseaseData['Risk']?.toString() ?? '';
                              //     diseaseadvice =
                              //         diseaseData['Advice']?.toString() ?? '';
                              //     diseasediagnosis =
                              //         diseaseData['Diagnosis']?.toString() ??
                              //             '';
                              //     diseasethreat =
                              //         diseaseData['Threat']?.toString() ?? '';
                              //
                              //     return print("data found");
                              //   } else {
                              //     return print(
                              //         "The disease does not exist in the database");
                              //   }
                              // } else {
                              //   return print("Loading...");
                              // }
                            }
                            setState(() {
                              loading = false;
                              _confirmbuttonvisibli = false;
                              _viewresultbutton = true;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyan.shade600,
                            onPrimary: Colors.white,
                          ),
                          child: Container(
                            margin: EdgeInsets.only(
                                top: 15, bottom: 15, left: 100, right: 100),
                            child: Text(
                              'Confirm',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                          ),
                        ),
                      ),
              ),
              SizedBox(
                height: 20,
              ),
              Visibility(
                visible: _viewresultbutton,
                child: ElevatedButton(
                  onPressed: () async {







                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Results3(
                                  results: result,
                                  Diseasename: diseasename,
                                  confidence: confidencelevel,
                                  imagefile: images,
                                  Diseasecondition: diseasecondition,
                                  Diseasethreat: diseasethreat,
                                  Diseaserisk: diseaserisk,
                                  Diseasediagnosis: diseasediagnosis,
                                  Diseasetreatment: diseasetreatment,
                                  Diseaseadvice: diseaseadvice,
                                )));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan.shade600,
                    onPrimary: Colors.white,
                  ),
                  child: Container(
                    margin: EdgeInsets.only(
                        top: 15, bottom: 15, left: 75, right: 75),
                    child: Text(
                      'View Result  ->',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () async {
                  final diseasesnapshot = await firebasediseaseref
                      .child('Disease/$diseasename')
                      .get();
                  print(diseasesnapshot.child('Condition').value.toString());
                  print(diseasesnapshot.child('Treatment').value.toString());
                  print(diseasesnapshot.child('Risk').value.toString());
                  print(diseasesnapshot.child('Advice').value.toString());
                  print(diseasesnapshot.child('Diagnosis').value.toString());
                  print(diseasesnapshot.child('Threat').value.toString());

                  var snapshot = await ref.child(diseasename).get();
                  snapshot.children.forEach((childSnapshot) {
                    var props = childSnapshot.value as Map;
                    print(props["Condition"]);
                  });
                },
                child: Container(
                  height: 100,
                  width: 200,
                  color: Colors.lightGreen,
                ),
              )
            ],
          ),
        ),
      ])));

  Future chooseOption() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Choose:"),
            backgroundColor: Colors.cyan.shade100,
            content: Container(
              height: MediaQuery.of(context).size.height * 0.19,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).maybePop();
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Text('Take Image from Camera'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () async {
                      _imgFromGallery();
                      Navigator.of(context).maybePop();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Text('Select from Gallery'),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Container(
                  margin: EdgeInsets.all(0.0),
                  padding: EdgeInsets.all(0.0),
                  child: CloseButton())
            ],
          ));
}

class Disease {
  final String advice;
  final String condition;
  final String diagnosis;
  final String name;
  final String risk;
  final String threat;
  final String treatment;

  Disease({
    required this.advice,
    required this.condition,
    required this.diagnosis,
    required this.name,
    required this.risk,
    required this.threat,
    required this.treatment,
  });
}

Future<Disease?> loadJsonData(String diseaseName) async {
  // Load the JSON data from the asset file
  String jsonString = await rootBundle.loadString('assets/disease.json');

  // Parse the JSON data
  final List<dynamic> jsonData = json.decode(jsonString)['Disease'];

  // Find the disease with the specified name (case-insensitive comparison)
  final diseaseData = jsonData.firstWhere(
    (disease) =>
        disease['Name'].toString().toLowerCase() == diseaseName.toLowerCase(),
    orElse: () => null,
  );

  // Return null if the disease was not found
  if (diseaseData == null) return null;

  // Create a Disease object with the retrieved data
  return Disease(
    advice: diseaseData['Advice'],
    condition: diseaseData['Condition'],
    diagnosis: diseaseData['Diagnosis'],
    name: diseaseData['Name'],
    risk: diseaseData['Risk'],
    threat: diseaseData['Threat'],
    treatment: diseaseData['Treatment'],
  );
}
