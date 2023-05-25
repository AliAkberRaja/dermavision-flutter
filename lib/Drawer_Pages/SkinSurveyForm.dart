import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

enum Gender { male, female }

class SkinSurveyForm extends StatefulWidget {
  const SkinSurveyForm({Key? key}) : super(key: key);

  @override
  State<SkinSurveyForm> createState() => _SkinSurveyFormState();
}

final List<Map<String, dynamic>> issuesData = [
  {"ID": 184, "Name": "Hardening of the skin"},
  {"ID": 21, "Name": "Itching of skin"},
  {"ID": 217, "Name": "Skin thickening"},
  {"ID": 34, "Name": "Skin wheal"},
];

class _SkinSurveyFormState extends State<SkinSurveyForm> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  bool loading = false;
  bool _confirmbuttonvisibli = true;
  bool _viewresultbutton = false;
  bool resultvisibility = false;

  List<int> _finalselectedIssue = [];
  List<int> _selectedIssues = [];
  Gender? _usergender;
  String patientgender = "";
  int? selectedOption = 0;
  String patientage = "";
  int _selectedSkinValue = 0;
  int _selectedFlakingValue = 0;
  int _selectedWoundsValue = 0;
  String tokenofapi = '';
  var diagnosisData;
  List<int> _selectedSkinIssues = [];
  var data;
  List<Color> gradientColors = [
    Color(0xffa077ea),
    Color(0xff00c4b2),
  ];

  void fetchData() async {
    final token = await authenticate();

    if (token != null) {
      //final diagnosisData = await displayDiagnosis();
    }
  }

  Future<String?> authenticate() async {
    final uri = Uri.parse("https://authservice.priaid.ch/login");
    final apiKey = "Tq6w7_GMAIL_COM_AUT";
    final secretKey = "Hs8e6GLi2o9QSj45T";
    final secretBytes = utf8.encode(secretKey);
    String computedHashString = '';

    final hmac = Hmac(md5, secretBytes);
    final dataBytes = utf8.encode(uri.toString());
    final computedHash = hmac.convert(dataBytes);
    computedHashString = base64.encode(computedHash.bytes);

    final headers = {
      'Authorization': 'Bearer $apiKey:$computedHashString',
    };

    try {
      final response = await http.post(uri, headers: headers);
      final responseBody = response.body;

      final token = json.decode(responseBody)['Token'];
      tokenofapi = token.toString();
      print(tokenofapi);
      return token;
    } catch (e) {
      final errorMessage = e.toString();
      print(errorMessage);
      // Handle exception
      return null;
    }
  }

  void displayDiagnosis() async {
    final symptoms = _finalselectedIssue.toString();
    String gender = patientgender;
    String yob = ageInput.text.toString();
    print(symptoms);
    print(gender);
    print(yob);

    final diagnosis = 'https://healthservice.priaid.ch/diagnosis?token=' +
        tokenofapi +
        '&language=en-gb&symptoms=$symptoms&gender=$gender&year_of_birth=$yob';

    try {
      final response = await http.get(Uri.parse(diagnosis));
      diagnosisData = json.decode(response.body);
      print(diagnosisData);
      data = jsonDecode(response.body.toString());
      print(data);


    } catch (e) {
      print(e);
    }
  }

  TextEditingController ageInput = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skin Symptoms Checker'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade300,
        leadingWidth: 50,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                  child: Text("Gender:",
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
                          value: Gender.male,
                          contentPadding: EdgeInsets.all(0.0),
                          tileColor: Colors.purple.shade100,
                          visualDensity: VisualDensity.compact,
                          selectedTileColor: Colors.purple.shade700,
                          dense: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0)),
                          groupValue: _usergender,
                          title: Text(Gender.male.name),
                          onChanged: (val) {
                            setState(() {
                              _usergender = val;
                              patientgender = "male";
                            });
                          })),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: RadioListTile<Gender>(
                        value: Gender.female,
                        dense: true,
                        visualDensity: VisualDensity.compact,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0)),
                        contentPadding: EdgeInsets.all(0.0),
                        tileColor: Colors.purple.shade100,
                        groupValue: _usergender,
                        title: Text(Gender.female.name),
                        onChanged: (val) {
                          setState(() {
                            _usergender = val;
                            patientgender = "female";
                          });
                        }),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                  child: Text("Age:",
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
                  keyboardType: TextInputType.number,
                  controller: ageInput,
                  decoration: InputDecoration(
                      // fillColor: Colors.purple.shade200,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.purple.shade200, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.purple.shade200, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      icon: Icon(
                        Icons.date_range_outlined,
                        size: 28,
                        color: Colors.purple.shade200,
                      ),

                      //icon of text field
                      labelText: "Enter Age",
                      labelStyle: TextStyle(
                        color: Colors.purple.shade400,
                      ) //label text of field
                      ),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select from following issues:',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    Column(
                      children: [
                        CheckboxListTile(
                          value: _selectedIssues.contains(124),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value!) {
                                _selectedIssues.add(124);
                              } else {
                                _selectedIssues.remove(124);
                              }
                            });
                          },
                          title: Text('Skin Rash'),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        CheckboxListTile(
                          value: _selectedIssues.contains(61),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value!) {
                                _selectedIssues.add(61);
                              } else {
                                _selectedIssues.remove(61);
                              }
                            });
                          },
                          title: Text('Skin Redness'),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        CheckboxListTile(
                          value: _selectedIssues.contains(26),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value!) {
                                _selectedIssues.add(26);
                              } else {
                                _selectedIssues.remove(26);
                              }
                            });
                          },
                          title: Text('Skin Lesion'),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        CheckboxListTile(
                          value: _selectedIssues.contains(25),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value!) {
                                _selectedIssues.add(25);
                              } else {
                                _selectedIssues.remove(25);
                              }
                            });
                          },
                          title: Text('Skin Nodules'),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.purple.shade50),
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select the visible color on your skin:',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 16.0),
                    Column(
                      children: [
                        RadioListTile<int>(
                          title: Text('No Visible Coloring or Skin Spots'),
                          value: 0,
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              selectedOption = value;
                            });
                          },
                          contentPadding: EdgeInsets.zero,
                          activeColor: Colors.purple.shade200,
                        ),
                        RadioListTile<int>(
                          title: Text('Blue Colored Skin'),
                          value: 991,
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              selectedOption = value;
                            });
                          },
                          contentPadding: EdgeInsets.zero,
                          activeColor: Colors.purple.shade200,
                        ),
                        RadioListTile<int>(
                          title: Text('Blue Spot on Skin'),
                          value: 240,
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              selectedOption = value;
                            });
                          },
                          contentPadding: EdgeInsets.zero,
                          activeColor: Colors.purple.shade200,
                        ),
                        RadioListTile<int>(
                          title: Text('Yellow Colored Skin'),
                          value: 105,
                          groupValue: selectedOption,
                          onChanged: (value) {
                            setState(() {
                              selectedOption = value;
                            });
                          },
                          contentPadding: EdgeInsets.zero,
                          activeColor: Colors.purple.shade200,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Do you have a dry or moist skin?',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.0),
                    Column(
                      children: [
                        RadioListTile<int>(
                          value: 0,
                          groupValue: _selectedSkinValue,
                          onChanged: (value) {
                            setState(() {
                              _selectedSkinValue = value!;
                            });
                          },
                          title: Text('Normal SKin'),
                          contentPadding: EdgeInsets.zero,
                          activeColor: Colors.purple.shade200,
                        ),
                        RadioListTile<int>(
                          value: 151,
                          groupValue: _selectedSkinValue,
                          onChanged: (value) {
                            setState(() {
                              _selectedSkinValue = value!;
                            });
                          },
                          title: Text('Dry Skin'),
                          contentPadding: EdgeInsets.zero,
                          activeColor: Colors.purple.shade200,
                        ),
                        RadioListTile<int>(
                          value: 215,
                          groupValue: _selectedSkinValue,
                          onChanged: (value) {
                            setState(() {
                              _selectedSkinValue = value!;
                            });
                          },
                          title: Text('Moist and Softened Skin'),
                          contentPadding: EdgeInsets.zero,
                          activeColor: Colors.purple.shade200,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Do you have flaking skin?',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.0),
                    Column(
                      children: [
                        RadioListTile<int>(
                          value: 0,
                          groupValue: _selectedFlakingValue,
                          onChanged: (value) {
                            setState(() {
                              _selectedFlakingValue = value!;
                            });
                          },
                          title: Text('No flaking'),
                          contentPadding: EdgeInsets.zero,
                          activeColor: Colors.purple.shade200,
                        ),
                        RadioListTile<int>(
                          value: 214,
                          groupValue: _selectedFlakingValue,
                          onChanged: (value) {
                            setState(() {
                              _selectedFlakingValue = value!;
                            });
                          },
                          title: Text('Yes'),
                          contentPadding: EdgeInsets.zero,
                          activeColor: Colors.purple.shade200,
                        ),
                        RadioListTile<int>(
                          value: 245,
                          groupValue: _selectedFlakingValue,
                          onChanged: (value) {
                            setState(() {
                              _selectedFlakingValue = value!;
                            });
                          },
                          title: Text('Flaking on the head'),
                          contentPadding: EdgeInsets.zero,
                          activeColor: Colors.purple.shade200,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Do you have any wounds?',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.0),
                    Column(
                      children: [
                        RadioListTile<int>(
                          value: 0,
                          groupValue: _selectedWoundsValue,
                          onChanged: (value) {
                            setState(() {
                              _selectedWoundsValue = value!;
                            });
                          },
                          title: Text('No'),
                          contentPadding: EdgeInsets.zero,
                          activeColor: Colors.purple.shade200,
                        ),
                        RadioListTile<int>(
                          value: 62,
                          groupValue: _selectedWoundsValue,
                          onChanged: (value) {
                            setState(() {
                              _selectedWoundsValue = value!;
                            });
                          },
                          title: Text('Formation of blisters on a skin area'),
                          contentPadding: EdgeInsets.zero,
                          activeColor: Colors.purple.shade200,
                        ),
                        RadioListTile<int>(
                          value: 63,
                          groupValue: _selectedWoundsValue,
                          onChanged: (value) {
                            setState(() {
                              _selectedWoundsValue = value!;
                            });
                          },
                          title: Text('Non-healing skin wound'),
                          contentPadding: EdgeInsets.zero,
                          activeColor: Colors.purple.shade200,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select from the following issues:',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.0),
                    Column(
                      children: issuesData.map((issue) {
                        final int id = issue['ID'];
                        final String name = issue['Name'];
                        return CheckboxListTile(
                          value: _selectedSkinIssues.contains(id),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value!) {
                                _selectedSkinIssues.add(id);
                              } else {
                                _selectedSkinIssues.remove(id);
                              }
                            });
                          },
                          title: Text(name),
                          controlAffinity: ListTileControlAffinity.leading,
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.9,
                child: loading
                    ? Center(child: CircularProgressIndicator())
                    : Visibility(
                        visible: _confirmbuttonvisibli,
                        child: _confirmbuttonvisibli
                            ? ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    loading = true;
                                  });

                                  _finalselectedIssue.clear();
                                  _finalselectedIssue.addAll(_selectedIssues);
                                  _finalselectedIssue
                                      .addAll(_selectedSkinIssues);
                                  _finalselectedIssue.add(_selectedWoundsValue);
                                  _finalselectedIssue.add(_selectedSkinValue);
                                  _finalselectedIssue
                                      .add(_selectedFlakingValue);
                                  _finalselectedIssue.add(selectedOption!);
                                  _finalselectedIssue
                                      .removeWhere((issue) => issue == 0);
                                  displayDiagnosis();

                                  await Future.delayed(Duration(seconds: 3));

                                  if (data.toString().isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text(
                                            'Unfortunately, the algorithm could not find the disease'),
                                        backgroundColor:
                                            Colors.deepPurple.shade600,
                                      ),
                                    );

                                    setState(() {
                                      loading = false;
                                    });
                                  } else {
                                    setState(() {
                                      loading = false;
                                      _confirmbuttonvisibli = false;
                                      _viewresultbutton = true;
                                    });
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.deepPurple.shade300),
                                ),
                                child: Text(
                                  "Confirm",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              )
                            : Container(
                                width: 0,
                                height:
                                    0), // Empty container with zero dimensions
                      ),
              ),
              SizedBox(
                height: 20,
              ),
              Visibility(
                visible: _viewresultbutton,
                maintainSize: false,
                child: Container(
                  height: _viewresultbutton ? MediaQuery.of(context).size.height * 0.08 : 0,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ElevatedButton(
                    onPressed: () {
                      displayDiagnosis();
                      setState(() {
                        resultvisibility = true;
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.deepPurple.shade300,
                      ),
                    ),
                    child: Container(
                      child: Text(
                        'View Result  ->',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  ),
                ),
              ),


              Visibility(
                visible: resultvisibility,
                child: Container(
                  height: 360,
                  child: FutureBuilder(
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Click to View Results");
                      }

                      else {
                        return
                          ListView.builder(
                          physics: ScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              diagnosisData != null ? diagnosisData.length : 0,
                          itemBuilder: (context, index) {
                            try {
                              final item = diagnosisData[index];

                              return Card(
                                child: Column(
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                      height: 320,
                                      width: 300,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        gradient: LinearGradient(
                                          colors: gradientColors,
                                          stops: [0.1, 0.9],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white54,
                                                ),
                                                child: Text(
                                                    "Ranking : ${item['Issue']['Ranking'].toString()}"),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white54,
                                                ),
                                                child: Text(
                                                    "Accuracy : ${item['Issue']['Accuracy'].toString()}%"),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Disease Name: ${item['Issue']['Name'].toString()}",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Scientific Name: ${item['Issue']['ProfName'].toString()}",
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "ICD Name : ${item['Issue']['IcdName'].toString()}",
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } catch (e) {
                              print('Exception: $e');
                              return Container(); // Replace with your error widget or a blank container
                            }
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
