import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:time_planner/time_planner.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class StudentTimeTableScreen extends StatelessWidget {
  const StudentTimeTableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time planner Demo',
      scrollBehavior: MyCustomScrollBehavior(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Time planner'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<TimePlannerTask> tasks = [];

  @override
  void initState() {
    super.initState();
    _generateStaticTasks();
  }

  void _generateStaticTasks() {
    // Add predefined tasks with specific colors
    tasks.add(
      TimePlannerTask(
        color: Colors.blue,
        dateTime: TimePlannerDateTime(day: 0, hour: 8, minutes: 0),
        minutesDuration: 60,
        daysDuration: 1,
        child: Container(
          width: double.infinity,
          height: 40,
          color: Colors.blue,
        ),
      ),
    );
    tasks.add(
      TimePlannerTask(
        color: Colors.green,
        dateTime: TimePlannerDateTime(day: 2, hour: 12, minutes: 0),
        minutesDuration: 90,
        daysDuration: 2,
        child: Container(
          width: double.infinity,
          height: 40,
          color: Colors.green,
        ),
      ),
    );
    // Add more predefined tasks if needed
  }

  void _addRandomTask(BuildContext context) {
    List<Color?> colors = [
      Colors.purple,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.lime[600]
    ];

    setState(() {
      tasks.add(
        TimePlannerTask(
          color: colors[Random().nextInt(colors.length)],
          dateTime: TimePlannerDateTime(
            day: Random().nextInt(14),
            hour: Random().nextInt(18) + 6,
            minutes: Random().nextInt(60),
          ),
          minutesDuration: Random().nextInt(90) + 30,
          daysDuration: Random().nextInt(4) + 1,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('You clicked on a time planner object'),
            ));
          },
          child: Text(
            'this is a demo',
            style: TextStyle(color: Colors.grey[350], fontSize: 12),
          ),
        ),
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Random task added to time planner!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: TimePlanner(
          startHour: 6,
          endHour: 23,
          use24HourFormat: false,
          setTimeOnAxis: false,
          style: TimePlannerStyle(
            // cellHeight: 60,
            // cellWidth: 60,
            showScrollBar: true,
            interstitialEvenColor: Colors.grey[50],
            interstitialOddColor: Colors.grey[200],
          ),
          headers: const [
            TimePlannerTitle(date: "3/10/2021", title: "Sunday"),
            TimePlannerTitle(date: "3/11/2021", title: "Monday"),
            TimePlannerTitle(date: "3/12/2021", title: "Tuesday"),
            TimePlannerTitle(date: "3/13/2021", title: "Wednesday"),
            TimePlannerTitle(date: "3/14/2021", title: "Thursday"),
            TimePlannerTitle(date: "3/15/2021", title: "Friday"),
            TimePlannerTitle(date: "3/16/2021", title: "Saturday"),
            TimePlannerTitle(date: "3/17/2021", title: "Sunday"),
            TimePlannerTitle(date: "3/18/2021", title: "Monday"),
            TimePlannerTitle(date: "3/19/2021", title: "Tuesday"),
            TimePlannerTitle(date: "3/20/2021", title: "Wednesday"),
            TimePlannerTitle(date: "3/21/2021", title: "Thursday"),
            TimePlannerTitle(date: "3/22/2021", title: "Friday"),
            TimePlannerTitle(date: "3/23/2021", title: "Saturday"),
            TimePlannerTitle(date: "3/24/2021", title: "Tuesday"),
            TimePlannerTitle(date: "3/25/2021", title: "Wednesday"),
            TimePlannerTitle(date: "3/26/2021", title: "Thursday"),
            TimePlannerTitle(date: "3/27/2021", title: "Friday"),
            TimePlannerTitle(date: "3/28/2021", title: "Saturday"),
            TimePlannerTitle(date: "3/29/2021", title: "Friday"),
            TimePlannerTitle(date: "3/30/2021", title: "Saturday"),
          ],
          tasks: tasks,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addRandomTask(context),
        tooltip: 'Add random task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
