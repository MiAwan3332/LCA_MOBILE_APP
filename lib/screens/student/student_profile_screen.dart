import 'package:flutter/material.dart';
import 'package:lca_app/models/student_detail_model.dart';
import 'package:lca_app/services/student_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentProfileScreen extends StatefulWidget {
  @override
  _StudentProfileScreenState createState() =>
      _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  Future<StudentDetail?>? futureStudentDetail;

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
        futureStudentDetail = Student().fetchStudentDetails(studentId, context);
      });
    } else {
      setState(() {
        futureStudentDetail =
            Future.error('No student ID found in shared preferences');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFBA8E4F),
        title:
            Text('Profile', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<StudentDetail?>(
        future: futureStudentDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          } else {
            StudentDetail student = snapshot.data!;

            return Padding(
              padding: EdgeInsets.all(20.0),
              child: ListTile(
                title: Text(
                  'Name: ${student.name}',
                  style: TextStyle(fontSize: 18),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Email: ${student.email}',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Phone: ${student.phone}',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Admission Date: ${student.admission_date}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
