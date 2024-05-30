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
  List<dynamic> seminars = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('token');

    final String apiUrl = 'https://lca-system-backend.vercel.app/seminars';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $authToken', 
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          seminars = responseData; 
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  void _openQRScanner(String seminarName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRScannerScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(seminars);
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Seminars'),
        backgroundColor: Color(0xFFBA8E4F),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: seminars.length,
          itemBuilder: (context, index) {
            final seminar = seminars[index];
            return Card(
              child: ListTile(
                title: Text(seminar['name'] ?? ''),
                subtitle: Text(seminar['email'] ?? ''),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SeminarFormScreen(seminarId: seminar['_id']),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
