import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lca_app/models/student_attendance_model.dart';
import './../services/generic_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendenceServices {
  final GenericServices _genericServices = GenericServices();
  Future<void> attendenceFunction(
      String? studentId, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token');

    final url =
        Uri.parse('https://lca-system-backend.vercel.app/attendence/create');

    Map<String, dynamic> body = {
      'student_id': studentId
      // 'student_id': 
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
        var decodedResponse = jsonDecode(response.body);

        _genericServices.showCustomToast(
            (decodedResponse['message']), Colors.green);
      } else {
        var decodedResponse = jsonDecode(response.body);

        _genericServices.showCustomToast(
            (decodedResponse['message']), Colors.red);
      }
    } catch (e) {
      print('Error: $e');
      _genericServices.showCustomToast('An error occurred: $e', Colors.red);
    }
  }

  Future<List<Attendance>> fetchStudentAttendanceById(String studentId) async {
    String url =
        'https://lca-system-backend.vercel.app/attendence/studentAttendence/$studentId';

    final response = await http.get(Uri.parse(url));
    print(response.body);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      if (jsonResponse.isNotEmpty) {
        return jsonResponse.map((data) => Attendance.fromJson(data)).toList();
      } else {
        throw Exception('No attendance found');
      }
    } else {
      throw Exception('Failed to load attendance');
    }
  }
}
