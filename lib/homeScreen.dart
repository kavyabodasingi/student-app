import 'package:flutter/material.dart';
import 'package:student/attendanceMark.dart';
import 'package:student/profileScreen.dart';


class HomeScreen extends StatefulWidget {
  final String userEmail;

  const HomeScreen({Key? key, required this.userEmail}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  
  Widget build(BuildContext context) {
    double screenHeight=MediaQuery.of(context).size.height;
    double screenWidth=MediaQuery.of(context).size.width;
    double baseFontSize=screenWidth*0.04;
    int crossAxisCount = (screenWidth ~/ 200).clamp(2, 4);
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(screenHeight*0.1), child: appbar()),
      bottomNavigationBar: bottomNavigator(),
      drawer: Drawer(
        elevation: 3,
        backgroundColor: Colors.white.withOpacity(0.6),
        width: screenWidth*0.7,
        child:ListView(
          children: [
            DrawerHeader(decoration: BoxDecoration(),child:Container(child: Row(
              children: [
                    Container(
                      width:100,
                      height:100,
                      child: CircleAvatar(
                        backgroundImage: AssetImage("assets/images/default_profile.png"),
                        
                      ),
                    ),
                    Spacer(),
                    Column(
                      children: [
                        SizedBox(height: screenHeight*0.05,),
                        Text("Yash",style: TextStyle(fontSize: screenWidth*0.06,fontWeight: FontWeight.w600),),
                        Text("07:12:55",style: TextStyle(fontSize:screenWidth*0.03),),
                      ],
                    ),
                  ],
                
              
            ),))
          ],
        )
      ),
      body:Padding(
        padding: const EdgeInsets.only(top:50),
        child: Container(
          width:screenWidth*0.8,
          height:screenHeight*0.9,
          
          child: GridView.count(
            padding: EdgeInsets.fromLTRB(screenWidth*0.1, 0, 0, screenHeight*0.4),
            crossAxisCount: crossAxisCount, // Number of columns
            crossAxisSpacing: 20.0, // Spacing between columns
            mainAxisSpacing: 20.0, // Spacing between rows
            children: List.generate(7, (index) {
              // Generate 6 cards
              return Card(
                
                elevation: 5,
                child: Container(
                  width: screenWidth*0.3 ,
                  height:screenHeight *0.04,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: screenWidth*0.04,),
                      Text(
                        'Card $index',
                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Description of Card $index',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      )
    );
  }
  Widget appbar(){
    double screenHeight=MediaQuery.of(context).size.height;
    double screenWidth=MediaQuery.of(context).size.width;
    return AppBar(
        
        actions:[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              // padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
              width: screenWidth*0.1,
              height: screenHeight*0.1,
            child:CircleAvatar(
              backgroundImage: AssetImage("assets/images/default_profile.png"),
            )),
          ),
        ]
      );
  }
  Widget bottomNavigator(){
    int index=0;
    List<Widget> widgetList = [
    HomeScreen(userEmail: widget.userEmail,),
    AttendanceMark(),
    ProfileScreen(userEmail: widget.userEmail,)
  ];
    return BottomNavigationBar(
      currentIndex: index,
      onTap: (index){
        setState(() {
          index=index;
        });
        Navigator.push(context,MaterialPageRoute(builder: (_)=>widgetList[index]));
        BackButton(color:Colors.grey);
      },
      items: [
      BottomNavigationBarItem(icon: Icon(Icons.home),
      label:'Home',
      ),
      BottomNavigationBarItem(icon: Icon(Icons.assignment_turned_in_rounded),
      label:'Attendance',
      ),
      BottomNavigationBarItem(icon: Icon(Icons.person),
      label:'Profile',
      ),
      
      
    ],
      
    );
  }
}

