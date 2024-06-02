import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'signin_screen.dart';
import './screens/admin/dashboard_screen.dart';
import './screens/student/student_dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getPrefrenceData();
  }

  Future<void> getPrefrenceData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? role = prefs.getString('role');
    int? timestamp = prefs.getInt('timestamp_role');

    if (timestamp != null) {
      final currentTime = DateTime.now().millisecondsSinceEpoch;
      final elapsed = currentTime - timestamp;
      // elapsed > 24 * 60 * 60 * 1000  // 24 hours in milliseconds
      // elapsed > 30 * 1000 // 30 seconds in milliseconds
      if (elapsed > 24 * 60 * 60 * 1000) { 
        // Clear preferences if 24 hours have passed
        await prefs.remove('role');
        await prefs.remove('timestamp_role');
        role = null;
       
      }
    }

    if (role == 'admin') {
      Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        ),
      );
    } else if (role == 'student') {
      Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => StudentDashboardScreen()),
        ),
      );
    } else {
      Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignInScreen()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Image.asset(
        'assets/images/logo-png.png',
        height: MediaQuery.of(context).size.height,
      ),
    );
  }
}
