import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentProfileScreen extends StatefulWidget {
  @override
  _StudentProfileScreenState createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  String? name;
  String? role;

  @override
  void initState() {
    super.initState();
    getdatafromsharedpreference();
  }

  Future<void> getdatafromsharedpreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
      role = prefs.getString("role");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fee Detail',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        backgroundColor: Color(0xFFBA8E4F),
        iconTheme: IconThemeData(color: Colors.white),// Dark brown background
        elevation: 0, // Remove elevation
        
      ),
       // Light beige background
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileRow('Name:', name),
            SizedBox(height: 16),
            _buildProfileRow('Role:', role),
            
          ],
        ),
      ),
    );
  }

  Widget _buildProfileRow(String label, String? value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Color(0xFF6D4C41),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(width: 8),
          Expanded(
            child: value != null
                ? Text(
                    value,
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ],
      ),
    );
  }
}
