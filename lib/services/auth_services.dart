import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/admin/dashboard_screen.dart';

class UserAuth {
  Future<void> loginUser(String email, String password, BuildContext context) async {
    
    final url = Uri.parse('https://lca-system-backend.vercel.app/users/login');

    Map<String, dynamic> body = {
      'email': email,
      'password': password,
    };

    String jsonBody = json.encode(body);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      final response = await http.post(url, headers: headers, body: jsonBody);

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);

         SharedPreferences prefs = await SharedPreferences.getInstance();
         String token = responseData['authToken'];
        await prefs.setString('token', token);
        
        // print('Response data: $token');
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // await prefs.setString('token', json.encode(token));
        Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  DashboardScreen()),
                  );

        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login successful'))
        );
      } else if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid email or password'))
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to login: ${response.reasonPhrase}'))
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e'))
      );
    }
  }
}
