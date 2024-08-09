import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/admin/dashboard_screen.dart';


class Seminar {
  Future<void> addUserToSeminar(
      String name,
      String contactNo,
      String city,
      String seminarId,
      String qualification,
      BuildContext context,
      List<String> selectedSeminars) async {
        
    final url = Uri.parse('https://api.lca-portal.com/attendees/add');
    print(seminarId);

    // Retrieve token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Token not found')),
      );
      return;
    }

    Map<String, dynamic> body = {
      'name': name,
      'phone': contactNo,
      'city': city,
      'qualification': qualification,
      'attend_type': selectedSeminars,
      'seminar_id': seminarId,
    };

    String jsonBody = json.encode(body);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.post(url, headers: headers, body: jsonBody);

      if (response.statusCode == 201) {
        var responseData = json.decode(response.body);
        // Uncomment the below line if you want to navigate to the DashboardScreen on success
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => DashboardScreen()),
        // );
       
                

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Student added successfully')),
        );
      } else if (response.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid credentials')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add student: ${response.reasonPhrase}')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }
}
