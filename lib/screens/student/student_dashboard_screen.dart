import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lca_app/change_password_screen.dart';
import 'package:lca_app/screens/student/student_attendance_screen.dart';
import 'package:lca_app/screens/student/student_fee_details_screen.dart';
import 'package:lca_app/screens/student/student_profile_screen.dart';
import 'package:lca_app/screens/student/subjects_screen.dart';
import 'package:lca_app/signin_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import '../admin/seminar_screen.dart';
// import '../admin/qrscanner_screen.dart';
import './student_time_table_screen.dart';
import '../../services/generic_services.dart';


class StudentDashboardScreen extends StatelessWidget {
  DateTime? currentBackPressTime;
    GenericServices _genericServices = GenericServices();

    Future<bool> onWillPop() async {
      DateTime now = DateTime.now();
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
        currentBackPressTime = now;
        _genericServices.showCustomToast('Press again to exit', Colors.black);
        return Future.value(false);
      }
      exit(0);
    }
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFBA8E4F),
          title: Text(
            'Lahore CSS Academy',
            style: TextStyle(color: Colors.white),
          ),
          automaticallyImplyLeading: false,
          actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'logout') {
                SharedPreferences preferences = await SharedPreferences.getInstance();
                await preferences.clear();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
              } else if (value == 'change_password') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
                );
              } else if (value == 'profile') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StudentProfileScreen()),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Logout', 'Change Password', 'Profile'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice.toLowerCase().replaceAll(' ', '_'),
                  child: Text(choice),
                );
              }).toList();
            },
            icon: Icon(Icons.more_vert, color: Colors.white),
          ),
        ],
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 20.0,
            mainAxisSpacing: 20.0,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SubjectsScreen()),
                  );
                },
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.subject,
                          size: 50,
                          color: Colors.orange,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Subjects',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StudentAttendanceScreen()),
                  );
                },
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.assignment,
                          size: 50,
                          color: Colors.blue,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Attendance',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
               InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StudentTimeTableScreen()),
                  );
                },
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.event_note,
                          size: 50,
                          color: Colors.purple,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Time Table',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StudentFeeDetailsScreen()),
                  );
                },
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.payments,
                          size: 50,
                          color: Colors.blueGrey,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Fee Details',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
