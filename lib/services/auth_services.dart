import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lca_app/screens/student/student_dashboard_screen.dart';
import 'package:lca_app/screens/student/student_info_form_screen.dart';
import 'package:lca_app/services/student_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/admin/dashboard_screen.dart';
import '../models/student_profile_model.dart';

class UserAuth {
  final Student _student = Student();

 Future<void> loginUser(String email, String password, BuildContext context) async {
  final url = Uri.parse('https://lca-system-backend.vercel.app/users/login');

  Map<String, dynamic> body = {
    'email': email,
    'password': password,
  };

  String jsonBody = json.encode(body);

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  try {
    final response = await http.post(url, headers: headers, body: jsonBody);

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      print('Response data: $responseData');

      if (responseData != null && responseData['authToken'] != null && responseData['role'] != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String token = responseData['authToken'];
        await prefs.setString('token', token);
        String role = responseData['role'];
        await prefs.setString('role', role);

        if (responseData['studentData'] != null && responseData['studentData']['name'] != null) {
          String name = responseData['studentData']['name'];
          await prefs.setString('name', name);
        } else {
          print('studentData or name is null');
        }

        await prefs.setInt('timestamp_role', DateTime.now().millisecondsSinceEpoch);
        print('Role: ${responseData['role']}');

        if (role == 'student') {
          if (responseData['studentData'] != null && responseData['studentData']['_id'] != null) {
            String studentId = responseData['studentData']['_id'];
            await prefs.setString('studentId', studentId);
            //   Map<String, dynamic> jsonData = jsonDecode(responseData['studentData']);
            //   List<dynamic> studentList = jsonData['studentData'];
            //   List<StudentModel> studentsModelData = studentList.map((json) => StudentModel.fromJson(json)).toList();
            // // print(responseData['studentData']);
            // _student.checkFormStatus(token, studentId, context); // Ensure this is defined
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StudentDashboardScreen()), // Ensure this is defined
            );
          } else {
            print('studentData or _id is null');
          }
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DashboardScreen()), // Ensure this is defined
          );
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login successful')),
        );
      } else {
        print('authToken or role is null');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid response data')),
        );
      }
    } else if (response.statusCode == 401) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid email or password')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to login: ${response.reasonPhrase}')),
      );
    }
  } catch (e) {
    print('Error: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('An error occurred: $e')),
    );
  }
}

  Future<void> changePassword(String email, String currentPassword,
      String newPassword, BuildContext context) async {
    final url =
        Uri.parse('https://lca-system-backend.vercel.app/users/changePassword');

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
      'email': email,
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    };

    String jsonBody = json.encode(body);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.post(url, headers: headers, body: jsonBody);

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password Reset Successfully')),
        );
      } else if (response.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid credentials')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Failed to change password: ${response.reasonPhrase}')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  Future<void> forgotPassword(String email, BuildContext context) async {
    final url =
        Uri.parse('https://lca-system-backend.vercel.app/users/forgotPassword');

    Map<String, dynamic> body = {
      'email': email,
    };

    String jsonBody = json.encode(body);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      final response = await http.post(url, headers: headers, body: jsonBody);

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password Sent Successfully')),
        );
      } else if (response.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid credentials')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Failed to send password: ${response.reasonPhrase}')),
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
