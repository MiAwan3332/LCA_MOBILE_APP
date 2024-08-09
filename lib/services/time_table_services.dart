// api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/time_table_model.dart';

class TimeTableServices {
  static const String url =
      'https://api.lca-portal.com/timetable/today/get';

  static Future<List<Timetable>> fetchTimetable() async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((item) => Timetable.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load timetable: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching timetable: $e');
      throw Exception('Failed to load timetable: $e');
    }
  }

  Future<List<Timetable>> fetchStudentTimetableById(String studentId) async {
  String url =
      'https://api.lca-portal.com/timetable/get-time-table-by-student-id/$studentId';

  final response = await http.get(Uri.parse(url));
  print(response.body);

  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse.isNotEmpty) {
      return jsonResponse.map((data) => Timetable.fromJson(data)).toList();
    } else {
      throw Exception('No timetable found');
    }
  } else {
    throw Exception('Failed to load timetable');
  }
}
}
