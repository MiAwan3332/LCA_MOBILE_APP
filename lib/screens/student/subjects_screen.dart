import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../admin/qrscanner_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../admin/seminarform_screen.dart';

class SubjectsScreen extends StatefulWidget {
  @override
  _SubjectsScreenState createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  List<dynamic> courses = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? studentId = prefs.getString('studentId');

    final String apiUrl = 'https://api.lca-portal.com/courses/student/courses/${studentId}';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          courses = responseData['courses']; 
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(seminars);
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Subjects', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFFBA8E4F),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: courses.length,
          itemBuilder: (context, index) {
            final seminar = courses[index];
            return Card(
               color: Color.fromARGB(255, 255, 226, 186),
              child: ListTile(
                splashColor: Color(0xFFBA8E4F),
                title: Text(seminar['name'] ?? ''),
                subtitle: Text(seminar['description'] ?? ''),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         SeminarFormScreen(seminarId: seminar['_id']),
                  //   ),
                  // );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
