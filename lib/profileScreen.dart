import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student/homeScreen.dart';

import 'attendanceMark.dart';


class ProfileScreen extends StatefulWidget {
  final String userEmail;

  const ProfileScreen({Key? key, required this.userEmail}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _profileImage;

  
  var passwordConfirm = TextEditingController();
  @override
  void initState() {
    super.initState();
    _loadProfileData(); // Call _loadProfileData when the widget is initialized
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }
  TextEditingController _nameController = TextEditingController();
  // final _passwordCont=TextEditingController();
  TextEditingController _emailCon=TextEditingController();
  TextEditingController _yearContr=TextEditingController();
  TextEditingController _branch=TextEditingController();
  TextEditingController _secCont=TextEditingController();
  TextEditingController _IdCon=TextEditingController();
  
  Future<void> _loadProfileData() async {
  QuerySnapshot<Map<String, dynamic>> userDocs = await FirebaseFirestore.instance
      .collection('users')
      .where('Student email', isEqualTo: widget.userEmail)
      .get();

  if (userDocs.docs.isNotEmpty) {
    var userDoc = userDocs.docs.first;
    setState(() {
      _nameController.text = userDoc.get('Student name') ?? 'no name';
      _emailCon.text = userDoc.get('Student email') ?? 'no email';
      _IdCon.text = userDoc.get('Student Id') ?? 'no year';
      _yearContr.text = userDoc.get('Year') ?? 'no id';
      _branch.text = userDoc.get('Branch') ?? '';
      _secCont.text = userDoc.get('Section') ?? '';
    });
  }
}

  @override
  Widget build(BuildContext context) {
    Color containerColor=Theme.of(context).colorScheme.surface;
    final screenHeight=MediaQuery.of(context).size.height;
    final screenWidth=MediaQuery.of(context).size.width;
    final baseFontSize=screenWidth*0.05;
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(screenHeight*0.1), child: appbar()),
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
                        // TextFormField(
                        //   controller: _nameController,
                        //   decoration: InputDecoration(labelText: 'Name'),
                          
                          
                        // ),
                        Text("07:12:55",style: TextStyle(fontSize:screenWidth*0.03),),
                      ],
                    ),
                  ],
                
              
            ),))
          ],
        )
      ),
      bottomNavigationBar: bottomNavigator(),
      body:SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : AssetImage("assets/images/default_profile.png")
                            as ImageProvider,
                    child: _profileImage == null
                        ? Icon(Icons.edit, size: 50, color: Colors.white)
                        : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    _nameController.text, // Use name from text controller
                    style: TextStyle(fontSize: baseFontSize),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Text("Email Address", style: TextStyle(fontSize: baseFontSize)),
                        SizedBox(width: screenWidth * 0.01),
                        Text(":", style: TextStyle(fontSize: screenWidth * 0.035)),
                        SizedBox(width: screenWidth * 0.001),
                        Expanded(child:Text(
                    "Email-ID  :  ${_emailCon.text}", // Use ID from text controller
                    style: TextStyle(fontSize: baseFontSize),
                  ), )
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit),
                  iconSize: 20,
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "IdNumber   :  ${_IdCon.text}", // Use ID from text controller
                    style: TextStyle(fontSize: baseFontSize),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit),
                  iconSize: 20,
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Branch    :  ${_branch.text}", // Use branch from text controller
                    style: TextStyle(fontSize: baseFontSize),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit),
                  iconSize: 20,
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Section   :  ${_secCont.text}", // Use section from text controller
                    style: TextStyle(fontSize: baseFontSize),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit),
                  iconSize: 20,
                )
              ],
            ),
          ],
        ),
      ),
    ),
    );
  }
  Widget appbar(){
    double screenHeight=MediaQuery.of(context).size.height;
    double screenWidth=MediaQuery.of(context).size.width;
    return AppBar(
        title:Text(""),
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
      
    );}
}