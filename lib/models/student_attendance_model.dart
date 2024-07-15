// timetable_model.dart

import 'time_table_model.dart';

class Attendance {
  final String id;
  final String batch;
  final String student;
  final Course course;
  final String date;
  final String status;

  Attendance({
    required this.id,
    required this.batch,
    required this.course,
    required this.student,
    required this.date,
    required this.status,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json['_id'],
      batch: json['batch'],
      student: json['student'],
      course: Course.fromJson(json['course']),
      date: json['date'],
      status: json['status'],
    );
  }
}


class Course {
  final String id;
  final String name;
  final String description;
  final int version;
  final int fee;

  Course({
    required this.id,
    required this.name,
    required this.description,
    required this.version,
    required this.fee,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      fee: json['fee'],
      version: json['__v'],
    );
  }
}