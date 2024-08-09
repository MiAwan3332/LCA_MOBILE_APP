import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'qrscanner_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './seminarform_screen.dart';

class SeminarScreen extends StatefulWidget {
  @override
  _SeminarScreenState createState() => _SeminarScreenState();
}

class _SeminarScreenState extends State<SeminarScreen> {
  List<dynamic> seminars = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('token');

    // Replace 'your_api_endpoint' with the actual API endpoint you're using
    final String apiUrl = 'https://api.lca-portal.com/seminars';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $authToken', // Assuming it's a Bearer token
          'Content-Type': 'application/json',
          // Add any other headers your API requires
        },
      );

      if (response.statusCode == 200) {
        // Successful response, handle the data here
        // print('Response: ${response.body}');
        // Parse the JSON response
        final responseData = jsonDecode(response.body);
        setState(() {
          seminars = responseData; // Assign parsed data to seminars list
        });
      } else {
        // Request failed with non-200 status code
        // print('Request failed with status: ${response.statusCode}');
        // print('Response: ${response.body}');
      }
    } catch (error) {
      // Error occurred during the request
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
        title: Text('List of Seminars', style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFFBA8E4F),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: seminars.length,
          itemBuilder: (context, index) {
            final seminar = seminars[index];
            return Card(
              color: Color.fromARGB(255, 255, 226, 186),
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
