import 'package:flutter/material.dart';
import 'package:lca_app/models/student_detail_model.dart';
import 'package:lca_app/services/student_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentFeeDetailsScreen extends StatefulWidget {
  @override
  _StudentFeeDetailsScreenState createState() =>
      _StudentFeeDetailsScreenState();
}

class _StudentFeeDetailsScreenState extends State<StudentFeeDetailsScreen> {
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
            Text('Student Fee Details', style: TextStyle(color: Colors.white)),
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
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
                children: [
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.paid,
                            size: 50,
                            color: Colors.blue,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Total Fee',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            student.total_fee.toString(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.verified,
                            size: 50,
                            color: Colors.green,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Paid Fee',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            student.paid_fee.toString(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.info,
                            size: 50,
                            color: Colors.orange,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Remaining Fee',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            student.pending_fee.toString(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
