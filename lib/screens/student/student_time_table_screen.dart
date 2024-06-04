import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/time_table_services.dart';
// import 'timetable_service.dart';
// import 'timetable_model.dart';
import '../../models/time_table_model.dart';

class StudentTimeTableScreen extends StatefulWidget {
  @override
  _TimetableScreenState createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<StudentTimeTableScreen> {
  late Future<Timetable> futureTimetable;
  String? studentId;

  getdatafromsharedpreference() async {
       SharedPreferences prefs = await SharedPreferences.getInstance();
    studentId = prefs.getString('studentId');
    setState(() {
      studentId = studentId;
    });
  }
  @override
  void initState() {
    super.initState();
    getdatafromsharedpreference();
    futureTimetable = TimeTableServices().fetchStudentTimetableById(studentId);
  
  }


  

    
  @override
  Widget build(BuildContext context) {

         
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFBA8E4F),
        title: Text('Student Timetable', style: TextStyle(color: Colors.white),),

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
                ListTile(
                  title: Text(timetable.course.name),
                  subtitle: Text('${timetable.day} ${timetable.startTime} - ${timetable.endTime}'),
                ),
                ListTile(
                  title: Text(timetable.teacher.name),
                  subtitle: Text(timetable.teacher.email),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(timetable.teacher.image),
                  ),
                ),
                ListTile(
                  title: Text('Batch: ${timetable.batch.name}'),
                  subtitle: Text(timetable.batch.description),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
