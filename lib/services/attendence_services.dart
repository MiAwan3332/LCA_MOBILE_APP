import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './../services/generic_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendenceServices{
  final GenericServices _genericServices = GenericServices();
   Future<void> attendenceFunction(String? studentId, BuildContext context) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token =  await prefs.getString('token');

    final url = Uri.parse('https://lca-system-backend.vercel.app/attendence/create');

    Map<String, dynamic> body = {
      'student_id': studentId
    };

    String jsonBody = json.encode(body);
    

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.post(url, headers: headers, body: jsonBody);
      print('Response status: ${response.body}');

      if (response.statusCode == 200) {

        _genericServices.showCustomToast('Student has been marked as present', Colors.green);
        print('abc');
        print('Student has been marked as present');
        print('xyz');
      }  else {
       _genericServices.showCustomToast('Student has been marked as absent', Colors.red);
       print('Student has been marked as absent');
      }
    } catch (e) {
      print('Error: $e');
      _genericServices.showCustomToast('An error occurred: $e', Colors.red);
    }
  }
}