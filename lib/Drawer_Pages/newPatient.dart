import 'dart:convert';
import 'dart:io';
import 'package:derma_vision/Drawer_Pages/InstantResultPage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart' show rootBundle;

enum Gender { Male, Female }

class NewPatient extends StatefulWidget {
  @override
  State<NewPatient> createState() => _NewPatientState();
}

class _NewPatientState extends State<NewPatient> {
  @override
  void initState() {
    // implement initState
    super.initState();
    imagePicker = ImagePicker();
    dateInput.text = "";

    // initialize labeler
    createLabeler();
     doImageLabeling();
  }

  @override
  void dispose() {
    super.dispose();
    imageLabeler.close();
  }

  DatabaseReference ref = FirebaseDatabase.instance.ref("patients/");
  DatabaseReference diseaseref = FirebaseDatabase.instance.ref("Disease");
  final storageRef = FirebaseStorage.instance.ref();
  late ImagePicker imagePicker;
  File? images;
  String result = '';
  String diseasename = '';
  String confidencelevel = '';
  int patientage = 0;
  TextEditingController patientname = TextEditingController();
  String patientgender = "";
  Gender? _usergender;
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
  String detecteddisease = "";

  // declare ImageLabeler
  dynamic imageLabeler;


  Future<Widget> fetchData(String diseaseName) async {
    var snapshot = await diseaseref.child(diseaseName).get();
    var dataSnapshot = snapshot;

    if (dataSnapshot.value != null) {
      var diseaseData = dataSnapshot.value as Map<dynamic, dynamic>?;

      if (diseaseData != null) {
        diseasecondition = diseaseData['Condition']?.toString() ?? '';
        diseasetreatment = diseaseData['Treatment']?.toString() ?? '';
        diseaserisk = diseaseData['Risk']?.toString() ?? '';
        diseaseadvice = diseaseData['Advice']?.toString() ?? '';
        diseasediagnosis = diseaseData['Diagnosis']?.toString() ?? '';
        diseasethreat = diseaseData['Threat']?.toString() ?? '';

        return
            Text("data found");
      } else {
        return Text("The disease does not exist in the database");
      }
    } else {
      return Text("Loading...");
    }
  }

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
    final modelPath = await _getModel('assets/ml/efficientnet_lite0.tflite');
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

      result += "$text   ${confidence.toStringAsFixed(2)}\n";

      setState(() {
        fetchData(diseasename);
        result;
        detecteddisease = diseasename.toString();
       // diseasename;
       // diseasefromjson;
      });
    }
  }
//   Future<Map<String, dynamic>> loadAsset() async {
//     String jsonData = await rootBundle.loadString('assets/disease.json');
//     return jsonDecode(jsonData);
//
//   }
//
// // Function to get the disease details by name
//   dynamic getDiseaseDetails(String diseaseName, Map<String, dynamic> diseaseData) {
//     if (diseaseData.containsKey(diseaseName)) {
//       List<dynamic> diseases = diseaseData[diseaseName];
//       if (diseases.isNotEmpty) {
//         return diseases[0];
//       }
//     }
//     return null;
//   }

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
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.05,
                color: Colors.white70,
                alignment: Alignment.center,
                child: Text(
                  "Diagnositc Details",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
              Divider(
                height: 10,
                thickness: 0.5,
                indent: 7.5,
                endIndent: 7.5,
                color: Colors.grey.shade700,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(right: 10),
                child: TextField(
                  controller: patientname,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.account_circle_sharp,
                      size: 28,
                    ),
                    labelText: "Enter Patient Name",
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                  child: Text("Sex:",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: RadioListTile<Gender>(
                          value: Gender.Male,
                          contentPadding: EdgeInsets.all(0.0),
                          tileColor: Colors.cyan.shade100,
                          visualDensity: VisualDensity.compact,
                          selectedTileColor: Colors.cyan.shade700,
                          dense: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0)),
                          groupValue: _usergender,
                          title: Text(Gender.Male.name),
                          onChanged: (val) {
                            setState(() {
                              _usergender = val;
                              patientgender = "Male";
                            });
                          })),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: RadioListTile<Gender>(
                        value: Gender.Female,
                        dense: true,
                        visualDensity: VisualDensity.compact,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0)),
                        contentPadding: EdgeInsets.all(0.0),
                        tileColor: Colors.cyan.shade100,
                        groupValue: _usergender,
                        title: Text(Gender.Female.name),
                        onChanged: (val) {
                          setState(() {
                            _usergender = val;
                            patientgender = "Female";
                          });
                        }),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 10, top: 15, bottom: 5),
                  child: Text("Date of Birth:",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ))),
              Container(
                margin: EdgeInsets.only(
                  right: 10,
                ),
                child: TextField(
                  cursorColor: Colors.cyan,
                  controller: dateInput,

                  decoration:  InputDecoration(
                    icon: Icon(
                      Icons.calendar_month_sharp,
                      color: Colors.cyan,
                      size: 28,
                    ),
                    //icon of text field
                      fillColor: Colors.cyan,
                    labelText: "Select Date",
                    labelStyle: TextStyle(color: Colors.cyan.shade800)//label text of field
                  ),
                  readOnly: true,
                  onTap: () async {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950, 1, 1),
                      lastDate: DateTime.now(),
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            primaryColor: Colors.cyan, // Set your desired primary color
                            hintColor: Colors.cyan, // Set your desired accent color
                            colorScheme: ColorScheme.light(
                              primary: Colors.cyan, // Set your desired primary color
                            ),
                            buttonTheme: ButtonThemeData(
                              textTheme: ButtonTextTheme.primary, // Set your desired button text theme
                            ),
                          ),
                          child: child!,
                        );
                      },
                    ).then((selectedDate) {
                      if (selectedDate != null) {
                        // Handle the selected date
                        print('Selected date: $selectedDate');
                        var finalDate = selectedDate.day.toString() +
                            '-' +
                            selectedDate.month.toString() +
                            '-' +
                            selectedDate.year.toString();
                        dateInput.text = finalDate;
                        final selectedDateYear = selectedDate.year;
                        patientage = DateTime.now().year - selectedDateYear;
                      }
                    });


                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
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
                            textfield1 = patientname.value.text;
                            textfield2 = patientgender;
                            textfield3 = dateInput.value.text;
                            if (textfield1.isEmpty) {
                              setState(() {
                                loading = false;
                              });
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Please Enter Patient Name'),
                                backgroundColor:
                                    Colors.deepOrangeAccent.shade200,
                              ));
                            }
                            if (textfield2.isEmpty) {
                              setState(() {
                                loading = false;
                              });
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Please Select Gender'),
                                backgroundColor:
                                    Colors.deepOrangeAccent.shade200,
                              ));
                            }
                            if (textfield3.isEmpty) {
                              setState(() {
                                loading = false;
                              });
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Please Enter Date of Birth'),
                                backgroundColor:
                                    Colors.deepOrangeAccent.shade200,
                              ));
                            }

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
                            } else if (images?.existsSync != null &&
                                textfield2.isNotEmpty &&
                                textfield1.isNotEmpty &&
                                textfield3.isNotEmpty)
                            // return null if the text is valid
                            {
                              String? fileName = images?.path.split('/').last;
                              final imageRef = storageRef
                                  .child("patientdisease/" + fileName!);
                              final nameofimage=fileName;
                              DateTime now = DateTime.now();
                              var formatter = new DateFormat('dd-MM-yyyy');
                              String formattedDate = formatter.format(now);
                              currentdate = formattedDate;
                              File selectedImagePath = File(images!.path);

                              setState(() {
                                loading = true;
                              }); //Loader

                              var metadata = SettableMetadata(
                                contentType: "image/jpeg",
                              );
                              await imageRef
                                  .putFile(selectedImagePath, metadata)
                                  .whenComplete(() async {
                                imageUrl = await imageRef.getDownloadURL();
                                print("File Uploaded...");
                              });

                              String? newKey = ref.push().key;


                              fetchData(diseasename);

                              //
                              // Map<String, dynamic> diseaseData = await loadAsset();
                              //
                              // dynamic details = getDiseaseDetails(diseasename, diseaseData);
                              // if (details != null) {
                              //
                              //
                              //   diseasecondition = details['Condition'];
                              //   diseaserisk = details['Risk'];
                              //   diseasethreat = details['Threat'];
                              //   diseaseadvice = details['Advice'];
                              //   diseasediagnosis = details['Diagnosis'];
                              //   diseasetreatment = details['Treatment'];
                              //
                              //   print(details['Risk']);
                              //   print(details['Condition']);
                              //   print(details['Threat']);
                              //   print(details['Advice']);
                              //   print(details['Diagnosis']);
                              //   print(details['Name']);
                              //   print(details['Treatment']);
                              // } else {
                              //   print('Disease not found');
                              // }






                              await ref.child(newKey!).set({
                                "patientname": textfield1,
                                "DOB": textfield3,
                                "gender": textfield2,
                                "dateoftest": currentdate,
                                "patientage": patientage,
                                "reference": newKey,
                                "diseasename": diseasename,
                                "percentage": confidencelevel,
                                "condition": diseasecondition,
                                "threat": diseasethreat,
                                "risk": diseaserisk,
                                "diagnosis": diseasediagnosis,
                                "treatment": diseasetreatment,
                                "advice": diseaseadvice,
                                "imageurl": imageUrl,
                                "imagename":fileName,
                              });

                              setState(() {
                                loading = false;
                                _confirmbuttonvisibli = false;
                                _viewresultbutton = true;
                              });
                            } else
                              return;
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
                            builder: (context) => InstantResultPage(
                                  PatientName: textfield1,
                                  gender: textfield2,
                                  Age: patientage,
                                  DateofBirth: textfield3,
                                  DiseaseName: diseasename,
                                  Percentage: confidencelevel,
                                  diseaseimage: images,
                                  testdate: currentdate,
                                  Condition: diseasecondition,
                                  ThreatLevel: diseasethreat,
                                  Risk: diseaserisk,
                                  Diagnosis: diseasediagnosis,
                                  Treatment: diseasetreatment,
                                  Advice: diseaseadvice,
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


