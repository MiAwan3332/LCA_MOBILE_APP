import 'package:flutter/material.dart';
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
