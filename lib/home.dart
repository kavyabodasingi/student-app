import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student/SubjectAttendance.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> subjects = ['MA', 'CNS', 'ST', 'AI', 'OOAD'];
  final List<double> percent = [0.8, 0.6, 0.8, 0.6, 0.9];
  final double progress = 0.8;
  late List<bool> _isHovering;

  @override
  void initState() {
    super.initState();
    _isHovering = List<bool>.filled(subjects.length, false);
  }

  @override
  Widget build(BuildContext context) {
    final Swidth = MediaQuery.of(context).size.width;
    final Sheight = MediaQuery.of(context).size.height;
    int crossAxisCount = (Swidth ~/ 200).clamp(2, 4);
    final today = DateTime.now();
    final String day = DateFormat('EEEE').format(today);
    final date = DateFormat('MMMM d, yyyy').format(today);

    return Scaffold(
      appBar: AppBar(
        title: Text("Your App Title"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    children: [
                      Container(
                        width: Swidth * 0.2,
                        height: Swidth * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: AssetImage("assets/images/default_profile.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: Swidth * 0.02),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello👋 Name',
                            style: TextStyle(
                              fontSize: Swidth * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: Swidth * 0.02),
                          Row(
                            children: [
                              Text("Total Percentage:"),
                              SizedBox(width: Swidth * 0.05),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: Swidth * 0.3,
                                  child: LinearProgressIndicator(
                                    value: progress,
                                    backgroundColor: Colors.white,
                                    valueColor: AlwaysStoppedAnimation(Colors.green),
                                    minHeight: 9,
                                  ),
                                ),
                              ),
                              SizedBox(width: Swidth * 0.005),
                              Text('${(progress * 100).toInt()}%'),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: Sheight * 0.05),
              Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, size: Swidth * 0.1, color: Colors.blueAccent),
                    SizedBox(width: Swidth * 0.05),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Day  : $day",
                          style: TextStyle(
                            fontSize: Swidth * 0.03,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        SizedBox(height: Sheight * 0.01),
                        Text(
                          "Date : $date",
                          style: TextStyle(
                            fontSize: Swidth * 0.03,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 140, 68, 255),
                          ),
                        ),
                      ]
                    )
                  ]
                )
              ),
              ),
              SizedBox(height: Sheight * 0.03),
              SizedBox(width:Swidth*0.02),
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  width: Swidth * 0.9,
                  height: Sheight * 0.09,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.dashboard, size: Swidth * 0.07),
                      SizedBox(width: Swidth * 0.02),
                      Text(
                        "DASHBOARD",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Swidth * 0.05,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: Sheight * 0.05),
              Padding(
                padding: const EdgeInsets.all(0),
                child: Container(
                  width: Swidth * 0.9,
                  height: Sheight * 0.6,
                  child: GridView.count(
                    padding: EdgeInsets.fromLTRB(Swidth * 0.05, 0, Swidth * 0.05, Sheight * 0.05),
                    crossAxisCount: crossAxisCount, // Number of columns
                    crossAxisSpacing: 20.0, // Spacing between columns
                    mainAxisSpacing: 20.0, // Spacing between rows
                    children: List.generate(subjects.length, (index) {
                      return MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            _isHovering[index] = true;
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            _isHovering[index] = false;
                          });
                        },
                        child: Card(
                          
                          elevation: _isHovering[index] ? 10 : 5,
                          color: _isHovering[index] ? Colors.blueGrey[50] : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context,
                              MaterialPageRoute(builder: (_)=>SubjectAttendance(subjectName:subjects[index] , percent: percent[index])
                              ));
                            },
                            child: Container(
                              width: Swidth * 0.3,
                              height: Sheight * 0.15,
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    subjects[index],
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  // Container(
                                  //   width: Swidth * 0.3,
                                  //   child: ClipRRect(
                                  //     borderRadius: BorderRadius.circular(10.0),
                                  //     child: LinearProgressIndicator(
                                  //       value: percent[index],
                                  //       backgroundColor: Colors.white,
                                  //       valueColor: AlwaysStoppedAnimation<Color>(
                                  //         percent[index] < 0.7
                                  //             ? Colors.red
                                  //             : (percent[index] < 0.77
                                  //                 ? Colors.yellow
                                  //                 : Colors.green),
                                  //       ),
                                  //       minHeight: 9,
                                  //     ),
                                  //   ),
                                  // ),
                                  Container(
                                    width: Swidth * 0.2,
                                    height:Sheight*0.1,
                                      child:AspectRatio(
                                        aspectRatio: Swidth*0.005,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 6,
                                          value: percent[index],
                                          backgroundColor: const Color.fromARGB(255, 243, 214, 214),
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                            percent[index] < 0.7
                                                ? Colors.red
                                                : (percent[index] < 0.77
                                                    ? Colors.yellow
                                                    : Colors.green),
                                          ),
                                          ),
                                      ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    '${(percent[index] * 100).toInt()}%',
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
