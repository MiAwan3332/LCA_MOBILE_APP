import 'package:flutter/material.dart';
import 'package:lca_app/change_password_screen.dart';
import 'package:lca_app/signin_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../admin/seminar_screen.dart';
import '../admin/qrscanner_screen.dart';

class StudentDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            }
          },
          itemBuilder: (BuildContext context) {
            return {'Logout', 'Change Password'}.map((String choice) {
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
                  MaterialPageRoute(builder: (context) => SeminarScreen()),
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
                  MaterialPageRoute(builder: (context) => QRScannerScreen()),
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
          ],
        ),
      ),
    );
  }
}
