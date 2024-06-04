// main.dart
import 'package:flutter/material.dart';
import '../../services/time_table_services.dart';
import '../../models/time_table_model.dart';




class TimetableScreen extends StatefulWidget {
  @override
  _TimetableScreenState createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  late Future<List<Timetable>> futureTimetable;

  @override
  void initState() {
    super.initState();
    futureTimetable = TimeTableServices.fetchTimetable();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Color(0xFFBA8E4F),
        title: Text('Timetable',style: TextStyle(color: Colors.white),),
      ),
      body: FutureBuilder<List<Timetable>>(
        future: futureTimetable,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Timetable timetable = snapshot.data![index];
                return Card(
                  child: ListTile(
                    title: Text('${timetable.course.name} (${timetable.batch.name})'),
                    subtitle: Text('Teacher: ${timetable.teacher.name}\n'
                        'Day: ${timetable.day}\n'
                        'Time: ${timetable.startTime} - ${timetable.endTime}'),
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
