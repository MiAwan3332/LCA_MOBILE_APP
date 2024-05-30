import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lca_app/screens/student/student_dashboard_screen.dart';
import 'package:lca_app/screens/student/student_info_form_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/admin/dashboard_screen.dart';

class Student {
  Future<void> submitStudentInfo(
    String cnic,
    String city,
    String date_of_birth,
    String father_name,
    String father_phone,
    String latest_degree,
    String university,
    String completion_year,
    String marks_cgpa,
    File image,
    File cnic_image,
    File cnic_back_image,
    BuildContext context,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? studentId = prefs.getString('studentId');

    final url = Uri.parse(
        'https://lca-system-backend.vercel.app/students/studentInfoUpdate/$studentId');

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Token not found')),
      );
      return;
    }

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['cnic'] = cnic
        ..fields['city'] = city
        ..fields['date_of_birth'] = date_of_birth
        ..fields['father_name'] = father_name
        ..fields['father_phone'] = father_phone
        ..fields['latest_degree'] = latest_degree
        ..fields['university'] = university
        ..fields['completion_year'] = completion_year
        ..fields['marks_cgpa'] = marks_cgpa
        ..headers['Authorization'] = 'Bearer $token';

      request.files.add(await http.MultipartFile.fromPath('image', image.path));
      request.files.add(
          await http.MultipartFile.fromPath('cnic_image', cnic_image.path));
      request.files.add(await http.MultipartFile.fromPath(
          'cnic_back_image', cnic_back_image.path));

      // Debugging: Print the full URL and headers
      print("Request URL: ${request.url}");
      print("Request Headers: ${request.headers}");

      final response = await request.send();

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Student form submitted successfully')),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
      } else if (response.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid credentials')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Failed to submit student form: ${response.reasonPhrase}')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  Future<void> checkFormStatus(
      String token, String studentId, BuildContext context) async {
    final String apiUrl =
        'https://lca-system-backend.vercel.app/students/checkStudentFields/${studentId}';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        int check = responseData['check'];

        if (check == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StudentDashboardScreen()),
          );
        } else if (check == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StudentInfoFormScreen()),
          );
        }
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }
}
