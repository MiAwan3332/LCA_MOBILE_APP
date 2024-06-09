import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/time_table_services.dart';
import '../../models/time_table_model.dart';

class StudentTimeTableScreen extends StatefulWidget {
  @override
  _TimetableScreenState createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<StudentTimeTableScreen> {
  Future<Timetable>? futureTimetable;

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
        futureTimetable = TimeTableServices().fetchStudentTimetableById(studentId);
      });
    } else {
      setState(() {
        futureTimetable = Future.error('No student ID found in shared preferences');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFBA8E4F),
        title: Text('Student Timetable', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<Timetable>(
        future: futureTimetable,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          } else {
            Timetable timetable = snapshot.data!;
            return ListView(
              children: [
                //  ListTile(
                //   title: Text(timetable.teacher.name),
                //   subtitle: Text(timetable.teacher.email),
                //   leading: CircleAvatar(
                //     backgroundImage: NetworkImage(timetable.teacher.image),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Color.fromARGB(255, 255, 226, 186),
                    child: ListTile(
                      title: Text(timetable.course.name),
                      subtitle: Text('${timetable.day} ${timetable.startTime} - ${timetable.endTime}'),
                    ),
                  ),
                ),
               
                // ListTile(
                //   title: Text('Batch: ${timetable.batch.name}'),
                //   subtitle: Text(timetable.batch.description),
                // ),
              ],
            );
          }
        },
      ),
    );
  }
}
