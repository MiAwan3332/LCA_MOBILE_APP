// timetable_model.dart

class Timetable {
  final String id;
  final Batch batch;
  final Course course;
  final String startTime;
  final String endTime;
  final String day;
  final Teacher teacher;

  Timetable({
    required this.id,
    required this.batch,
    required this.course,
    required this.startTime,
    required this.endTime,
    required this.day,
    required this.teacher,
  });

  factory Timetable.fromJson(Map<String, dynamic> json) {
    return Timetable(
      id: json['_id'],
      batch: Batch.fromJson(json['batch']),
      course: Course.fromJson(json['course']),
      startTime: json['start_time'],
      endTime: json['end_time'],
      day: json['day'],
      teacher: Teacher.fromJson(json['teacher']),
    );
  }
}

class Batch {
  final String id;
  final String name;
  final String description;
  final String startDate;
  final String endDate;
  final List<String> courses;
  final List<String> teachers;
  final int version;
  final String batchFee;
  final String batchType;

  Batch({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.courses,
    required this.teachers,
    required this.version,
    required this.batchFee,
    required this.batchType,
  });

  factory Batch.fromJson(Map<String, dynamic> json) {
    return Batch(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      startDate: json['startdate'],
      endDate: json['enddate'],
      courses: List<String>.from(json['courses']),
      teachers: List<String>.from(json['teachers']),
      version: json['__v'],
      batchFee: json['batch_fee'],
      batchType: json['batch_type'],
    );
  }
}

class Course {
  final String id;
  final String name;
  final String description;
  final int version;

  Course({
    required this.id,
    required this.name,
    required this.description,
    required this.version,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      version: json['__v'],
    );
  }
}

class Teacher {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String resume;
  final String image;
  final int version;

  Teacher({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.resume,
    required this.image,
    required this.version,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      resume: json['resume'],
      image: json['image'],
      version: json['__v'],
    );
  }
}
