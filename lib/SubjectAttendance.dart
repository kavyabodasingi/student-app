import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
class SubjectAttendance extends StatefulWidget {
  final String subjectName;
  final double percent;
  const SubjectAttendance({super.key, required this.subjectName, required this.percent});

  @override
  State<SubjectAttendance> createState() => _SubjectAttendanceState();
}

class _SubjectAttendanceState extends State<SubjectAttendance> {
  
  List<String> classes = ['Total Classes Held', 'Presents', 'Absents'];
  List<double> presents = [0.7, 0.82,0.89];  // Total, Presents, Absents
  List<double> absents=[0.3,0.18,0.11];
  late Map<DateTime, List<String>> _events;
  List<Color> color=[Colors.green,Colors.red,Colors.blue];
  List<String> indicate=['Presents','Absents','Classes Held On'];
  
  @override
  void initState() {
    super.initState();
    _events = {
      DateTime.now().subtract(Duration(days: 2)): ['Absent'],
      DateTime.now().subtract(Duration(days: 1)): ['Present'],
      DateTime.now(): ['Absent'],
      DateTime.now().add(Duration(days: 1)): ['Present'],
      DateTime.now().add(Duration(days: 2)): ['Absent'],
    };
  }
  @override
  Widget build(BuildContext context) {
    final Swidth = MediaQuery.of(context).size.width;
    final Sheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children:[
            Text('${widget.subjectName}'),
            SizedBox(width: Swidth * 0.05),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: Swidth * 0.3,
                child: LinearProgressIndicator(
                  value: widget.percent,
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation(Colors.green),
                  minHeight: 9,
                ),
              ),
            ),
          ]
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                height: Sheight * 0.5, // Adjust the height as needed
                child: ListView.builder(
                  itemCount: classes.length,
                  itemBuilder: (BuildContext context, int index) { 
                    return Column(
                      children: [
                        Card(
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            width: Swidth * 0.9,
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text("${classes[index]}", style: TextStyle(fontSize: Swidth * 0.04)),
                                SizedBox(height: 10.0),
                                Padding(
                                  padding: const EdgeInsets.only(right: 80, left: 20.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: LinearProgressIndicator(
                                      value: classes[index] == 'Presents' ? presents[index] : absents[index],
                                      backgroundColor: Color.fromARGB(255, 252, 191, 191),
                                      valueColor: AlwaysStoppedAnimation(Colors.green),
                                      minHeight: 9,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ),
                        SizedBox(height: 15.0),
                      ],
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: List.generate(color.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          color: color[index],
                        ),
                        SizedBox(width: 10),
                        Text(indicate[index]),
                      ],
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height:Sheight*0.06),
            Text(
              "Calendar",
              style: TextStyle(fontSize: Swidth * 0.04, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TableCalendar(
              calendarFormat: CalendarFormat.month,
              startingDayOfWeek: StartingDayOfWeek.monday,
              daysOfWeekVisible: true,
              eventLoader: (day) {
                return _events[day] ?? [];
              },
              
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  // handle day selection
                });
              },
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  if (events.isNotEmpty) {
                    Color markerColor = events.contains('Present') ? Colors.green : Colors.red;
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 1.5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: markerColor,
                      ),
                      width: 7.0,
                      height: 7.0,
                    );
                  }
                  return SizedBox();
                },
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              focusedDay: DateTime.now(),
              firstDay: DateTime(2020),
              lastDay: DateTime(2030),
            ),
          ],
        ),
      ),
    );
  }
}