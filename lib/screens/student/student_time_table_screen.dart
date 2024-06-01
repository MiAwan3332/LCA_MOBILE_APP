import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart'; // Ensure this is imported for Color and other material components
import 'package:time_planner/time_planner.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
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
      title: 'Time Planner Demo',
      scrollBehavior: MyCustomScrollBehavior(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Time Planner'),
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
    List<Task> myTasks = [
      Task(
        color: Colors.blue,
        day: 0,
        hour: 8,
        minutes: 0,
        minutesDuration: 60,
        daysDuration: 1,
        description: 'abc',
      ),
      Task(
        color: Colors.green,
        day: 2,
        hour: 12,
        minutes: 0,
        minutesDuration: 90,
        daysDuration: 2,
        description: 'Meeting',
      ),
    ];
    _generateTasks(myTasks);
  }

  void _generateTasks(List<Task> tasksData) {
    tasks.clear();
    for (var taskData in tasksData) {
      tasks.add(
        TimePlannerTask(
          color: taskData.color,
          dateTime: TimePlannerDateTime(
            day: taskData.day,
            hour: taskData.hour,
            minutes: taskData.minutes,
          ),
          minutesDuration: taskData.minutesDuration,
          daysDuration: taskData.daysDuration,
          child: Container(
            width: double.infinity,
            height: 40,
            color: taskData.color,
            child: Text(taskData.description ?? ''),
          ),
        ),
      );
    }
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

class Task {
  final Color color;
  final int day;
  final int hour;
  final int minutes;
  final int minutesDuration;
  final int daysDuration;
  final String? description;

  Task({
    required this.color,
    required this.day,
    required this.hour,
    required this.minutes,
    required this.minutesDuration,
    required this.daysDuration,
    this.description,
  });
}
