import 'package:flutter/material.dart';
import './qrscanner_screen.dart';



class SeminarScreen extends StatefulWidget {
  @override
  _SeminarScreenState createState() => _SeminarScreenState();
}

class _SeminarScreenState extends State<SeminarScreen> {
  final List<String> items = List.generate(100, (index) => 'Seminar No $index');
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void _openQRScanner(String seminarName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRScannerScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Seminar'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(items[index]),
              onTap: () {
               _openQRScanner(items[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
