import 'package:flutter/material.dart';
import 'package:lca_app/models/student_attendance_model.dart';
import 'package:lca_app/services/attendence_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/time_table_services.dart';
import '../../models/time_table_model.dart';

class StudentAttendanceScreen extends StatefulWidget {
  @override
  _StudentAttendanceScreenState createState() => _StudentAttendanceScreenState();
}

class _StudentAttendanceScreenState extends State<StudentAttendanceScreen> {
  Future<List<Attendance>>? futureAttendance;

  @override
  void initState() {
    super.initState();
    getdatafromsharedpreference();
  }

  Future<void> getdatafromsharedpreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? studentId = prefs.getString('studentId');
    if (studentId != null) {
      setState(() {
        futureAttendance =
            AttendenceServices().fetchStudentAttendanceById(studentId);
      });
    } else {
      setState(() {
        futureAttendance =
            Future.error('No student ID found in shared preferences');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFBA8E4F),
        title: Text('Attendance', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<List<Attendance>>(
        future: futureAttendance,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Attendance attendance = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Color.fromARGB(255, 255, 226, 186),
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(attendance.course.name),
                          SizedBox(width: 10),
                          Text(attendance.status),
                        ],
                      ),
                      // subtitle: Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text('${timetable.teacher.name}'),
                      //     Text(
                      //         '${timetable.startTime} - ${timetable.endTime}'),
                      //   ],
                      // ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
 