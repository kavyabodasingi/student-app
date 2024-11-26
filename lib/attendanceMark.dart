import 'package:flutter/material.dart';
class AttendanceMark extends StatefulWidget {
  const AttendanceMark({super.key});

  @override
  State<AttendanceMark> createState() => _AttendanceMarkState();
}

class _AttendanceMarkState extends State<AttendanceMark> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Text("Attendance Mark Sheet"),
    );
  }
}