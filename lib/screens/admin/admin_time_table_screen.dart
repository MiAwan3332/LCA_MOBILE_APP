import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
        title: Text(
          'Timetable',
          style: TextStyle(color: Colors.white),
        ),
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
              padding: const EdgeInsets.all(16.0),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Timetable timetable = snapshot.data![index];
                return TimetableCard(timetable: timetable);
              },
            );
          }
        },
      ),
    );
  }
}

class TimetableCard extends StatelessWidget {
  final Timetable timetable;

  TimetableCard({required this.timetable});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 255, 226, 186),
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text(
                '${timetable.course.name}',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              Text(
              '${timetable.batch.name}',
              style: TextStyle(
                fontSize: 16.0,
                color: Color(0xFF555555),
              ),
            ),
            ]),
            SizedBox(height: 18.0),
            Text(
              'Teacher: ${timetable.teacher.name}',
              style: TextStyle(
                fontSize: 16.0,
                color: Color(0xFF555555),
              ),
            ),
            SizedBox(height: 4.0),
            Row(
              children: [
                Icon(
                  Icons.schedule,
                ),
                Text(
                  '${timetable.startTime} - ${timetable.endTime}',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color(0xFF555555),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
