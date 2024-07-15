import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'qrscanner_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import './seminarform_screen.dart';

class StudentProfileScreen extends StatefulWidget {
  @override
  _StudentProfileScreenState createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  List<dynamic> seminars = [];
  String? name;

  @override
  void initState() {
    super.initState();
    getdatafromsharedpreference();
  }

  Future<void> getdatafromsharedpreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFFBA8E4F),
      ),
      body: Column(
        children: [
          Row(children: [
            Text('Name: ',),
            Text(
              name!,
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],),
        ],
      )
    );
  }
}
