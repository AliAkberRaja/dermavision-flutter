import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Apitest extends StatefulWidget {
  const Apitest({Key? key}) : super(key: key);

  @override
  _ApitestState createState() => _ApitestState();
}

class _ApitestState extends State<Apitest> {

  var data ;
  Future<void> getUserApi ()async{
    final response = await http.get(Uri.parse('https://healthservice.priaid.ch/diagnosis?symptoms=[25,26]&gender=male&year_of_birth=25&token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6IjExMjUwQHN0dWRlbnRzLnJpcGhhaC5lZHUucGsiLCJyb2xlIjoiVXNlciIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL3NpZCI6Ijk2OTQiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3ZlcnNpb24iOiIxMDkiLCJodHRwOi8vZXhhbXBsZS5vcmcvY2xhaW1zL2xpbWl0IjoiMTAwIiwiaHR0cDovL2V4YW1wbGUub3JnL2NsYWltcy9tZW1iZXJzaGlwIjoiQmFzaWMiLCJodHRwOi8vZXhhbXBsZS5vcmcvY2xhaW1zL2xhbmd1YWdlIjoiZW4tZ2IiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL2V4cGlyYXRpb24iOiIyMDk5LTEyLTMxIiwiaHR0cDovL2V4YW1wbGUub3JnL2NsYWltcy9tZW1iZXJzaGlwc3RhcnQiOiIyMDIzLTA1LTE5IiwiaXNzIjoiaHR0cHM6Ly9hdXRoc2VydmljZS5wcmlhaWQuY2giLCJhdWQiOiJodHRwczovL2hlYWx0aHNlcnZpY2UucHJpYWlkLmNoIiwiZXhwIjoxNjg0NjE3MTQyLCJuYmYiOjE2ODQ2MDk5NDJ9.KgacNSJ8Fp8neFnGI_lSLZVGg1d-HjCNFt-IbyxpC5A&format=json&language=en-gb'));

    if(response.statusCode == 200){
      data = jsonDecode(response.body.toString());
    }else {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Api Course'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUserApi (),
              builder: (context , snapshot){

                if(snapshot.connectionState == ConnectionState.waiting){
                  return Text('Loading');
                }else {
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index){
                        return Card(
                          child: Column(
                            children: [
                              ReusbaleRow(title: 'id', value: data[index]['Issue']['ID'].toString(),),
                              ReusbaleRow(title: 'disease', value: data[index]['Issue']['Name'].toString(),),
                              // ReusbaleRow(title: 'address', value: data[index]['address']['street'].toString(),),
                              // ReusbaleRow(title: 'Lat', value: data[index]['address']['geo']['lat'].toString(),),
                              // ReusbaleRow(title: 'Lat', value: data[index]['address']['geo']['lng'].toString(),),

                            ],
                          ),
                        );
                      });
                }

              },
            ),
          )
        ],
      ),
    );
  }
}

class ReusbaleRow extends StatelessWidget {
  final title , value ;
  ReusbaleRow({Key? key , required this.title , required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value ),

            ],
           ),
      );
    }
}