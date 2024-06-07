// api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/time_table_model.dart';

class TimeTableServices {
  static const String url = 'https://lca-system-backend.vercel.app/timetable/today/get';

  static Future<List<Timetable>> fetchTimetable() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Timetable.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load timetable');
    }
  }


 
  static Future<List<Timetable>> fetchStudentTimetableById(String? studentId) async {
       String studenturl = 'https://lca-system-backend.vercel.app/timetable/get-time-table-by-student-id/${studentId}';

    final response = await http.get(Uri.parse(studenturl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Timetable.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load timetable');
    }
  }
}
