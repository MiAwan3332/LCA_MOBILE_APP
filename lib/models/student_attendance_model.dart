// timetable_model.dart

class Attendance {
  final String id;
  // final Batch batch;
  // final Course course;
  final String startTime;
  final String endTime;
  final String day;
  // final Teacher teacher;

  Attendance({
    required this.id,
    // required this.batch,
    // required this.course,
    required this.startTime,
    required this.endTime,
    required this.day,
    // required this.teacher,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json['_id'],
      // batch: Batch.fromJson(json['batch']),
      // course: Course.fromJson(json['course']),
      startTime: json['start_time'],
      endTime: json['end_time'],
      day: json['day'],
      // teacher: Teacher.fromJson(json['teacher']),
    );
  }
}