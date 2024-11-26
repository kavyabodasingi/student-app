import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student/Authentication/auth.dart';
import 'package:student/loginscreen.dart';




class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var stuName = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var id = TextEditingController();
  bool passwordObscured = true;
  final _formKey = GlobalKey<FormState>();
  String? _selectedBranch;
  String? _selectedSec;
  final List<String> years = ['PUC1', 'PUC2', 'E1', 'E2', 'E3', 'E4'];
  final List<String> branches = ['CSE', 'ECE', 'EEE', 'ME', 'CE'];
  final List<String> Sections = ['A', 'B', 'C', 'D', 'E', 'F'];
  File? _profileImage;

  final ImagePicker _picker = ImagePicker();

  String? _selectYear;

  var passwordConfirm = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }
    final _auth = AuthService();

  final FirebaseFirestore firestore=FirebaseFirestore.instance;
  Future<void> _signUp() async{
      final user=await _auth.signUpWithEmail(email.text, password.text);
      if(user!=null){
        await firestore.collection('users').doc(user.uid).set({
          'uid':user.uid,
          'Student Id':id.text,
          'Student name':stuName.text,
          "Year":_selectYear,
          'Branch':_selectedBranch,
          'Section':_selectedSec,
          'Student email':email.text,
          'password':password.text,
          
          }
        );
        ScaffoldMessenger.of(context).
        showSnackBar(SnackBar(content: Text("User Credentials saved successfully"),
        backgroundColor: Colors.green,
        duration: Duration(milliseconds: 1500),
        ));
      }

  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double baseFontSize = screenWidth * 0.03; // Adjust this value as needed
    double paddingValue = screenHeight * 0.1; // 10% of the screen height as padding

    return Scaffold(
      // appBar: PreferredSize(preferredSize:Size.fromHeight(60) , child: appbar()),
      body: Body(),
    );
  }

  Widget appbar() {
    double screenWidth = MediaQuery.of(context).size.width;
    double baseFontSize = screenWidth * 0.05;
    return AppBar(
      title: Text(
        "Let's SignUp..",
        style: TextStyle(
          fontSize: baseFontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget Body() {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double baseFontSize = screenWidth * 0.04; // Adjust this value as needed
    double paddingValue = screenHeight * 0.1;
    Color containerColor=Theme.of(context).colorScheme.surface;
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          // Container(
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       filterQuality: FilterQuality.low,
          //       fit: BoxFit.cover,
          //       image: AssetImage(
          //           "assets/images/Online-Attendance-Management-System.png"),
          //     ),
          //   ),
          // ),
          // BackdropFilter(
          //   filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          //   child: Container(
          //     color: Colors.black.withOpacity(0.3),
          //   ),
          // ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: paddingValue),
                Align(
                  alignment: Alignment.center,
                  child: FractionallySizedBox(
                    widthFactor: 0.85,
                    child: Container(
                      color:containerColor.withOpacity(0.6),
                      width: screenWidth * 0.9,
                      padding: EdgeInsets.all(20.0),
                      
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: _pickImage,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: _profileImage != null
                                    ? FileImage(_profileImage!)
                                    : AssetImage('assets/images/default_profile.png')
                                        as ImageProvider,
                                child: _profileImage == null
                                    ? Icon(
                                        Icons.camera_alt,
                                        size: 45,
                                        color: Colors.grey[700],
                                      )
                                    : null,
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.fromLTRB(12, 7, 12, 0),
                              child: TextFormField(
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please Enter Name";
                                  }
                                  return null;
                                },
                                controller: stuName,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.person),
                                  hintText: "Student Name",
                                  label: Text(
                                    "Name",
                                    style: TextStyle(fontSize: baseFontSize),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                style: TextStyle(fontSize: baseFontSize),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(12, 7, 12, 0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please Enter Id Number";
                                  }
                                  return null;
                                },
                                controller: id,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.badge),
                                  hintText: "Id Number",
                                  label: Text(
                                    "Id Number",
                                    style: TextStyle(fontSize: baseFontSize),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                style: TextStyle(fontSize: baseFontSize),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(12, 7, 12, 0),
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.school),
                                  hintText: "Select Year Of Studying",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                dropdownColor: containerColor.withOpacity(0.6),
                                items: years.map((String Year) {
                                  return DropdownMenuItem<String>(
                                      value: Year, child: Text(Year,style: TextStyle(fontSize: baseFontSize),));
                                }).toList(),
                                onChanged: (String? newvalue) {
                                  setState(() {
                                    _selectYear = newvalue;
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(12, 7, 12, 0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: DropdownButtonFormField(
                                      dropdownColor: containerColor.withOpacity(0.6),
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.engineering),
                                        hintText: "Select Branch",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      items: branches.map((String branch) {
                                        return DropdownMenuItem<String>(
                                          value: branch,
                                          child: Text(branch,style: TextStyle(fontSize: baseFontSize),),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _selectedBranch = newValue;
                                        });
                                      },
                                      validator: (value) => value == null
                                          ? "Please Select Branch Name"
                                          : null,
                                    ),
                                  ),
                                  SizedBox(width: 7),
                                  Expanded(
                                    child: DropdownButtonFormField(
                                      dropdownColor: Colors.white.withOpacity(0.6),
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.group),
                                        hintText: "Select Section",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                      items: Sections.map((String sec) {
                                        return DropdownMenuItem<String>(
                                          value: sec,
                                          child: Text(sec,style: TextStyle(fontSize: baseFontSize),),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _selectedSec = newValue;
                                        });
                                      },
                                      validator: (value) => value == null
                                          ? "Please Select Section"
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(12, 7, 12, 0),
                              child: TextFormField(
                                validator: (value) {
                                  final pattern =
                                      RegExp(r'^[S,s]\d{6}@rguktsklm\.ac\.in$');
                                  if (value == null || value.isEmpty) {
                                    return "Please Enter Email Address";
                                  } else if (!pattern.hasMatch(value)) {
                                    return "Please Enter Valid Email Address (e.g., S220311@rguktsklm.ac.in)";
                                  }
                                  return null;
                                },
                                controller: email,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.email),
                                  hintText: "College Email Address",
                                  label: Text(
                                    "Email Address",
                                    style: TextStyle(fontSize: baseFontSize),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                style: TextStyle(fontSize: baseFontSize),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(12, 7, 12, 0),
                              child: TextFormField(
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please Create Your Password";
                                  } else if (value.length < 6) {
                                    return "Password must be at least 6 characters long";
                                  }
                                  return null;
                                },
                                controller: password,
                                obscureText: passwordObscured,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    icon: Icon(passwordObscured
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        passwordObscured = !passwordObscured;
                                      });
                                    },
                                  ),
                                  hintText: "Create Password",
                                  label: Text(
                                    "Create Password",
                                    style: TextStyle(fontSize: baseFontSize),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                style: TextStyle(fontSize: baseFontSize),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(12, 7, 12, 0),
                              child: TextFormField(
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please Confirm Your Password";
                                  } else if (value != password.text) {
                                    return "Passwords do not match";
                                  }
                                  return null;
                                },
                                controller: passwordConfirm,
                                obscureText: passwordObscured,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.lock_outline),
                                  suffixIcon: IconButton(
                                    icon: Icon(passwordObscured
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        passwordObscured = !passwordObscured;
                                      });
                                    },
                                  ),
                                  hintText: "Confirm Password",
                                  label: Text(
                                    "Confirm Password",
                                    style: TextStyle(fontSize: baseFontSize),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                style: TextStyle(fontSize: baseFontSize),
                              ),
                            ),
                            SizedBox(height: 25),
                            Center(
                              child: ElevatedButton(
                                onPressed: () async{
                                  if (_formKey.currentState!.validate()) {
                                    
                                  await _signUp();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()));
                                  }
                                },
                                child: Text(
                                  "SignUp",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: baseFontSize),
                                ),
                                style: ElevatedButton.styleFrom(
                                  
                                  fixedSize: Size(screenWidth*0.72, screenHeight*0.058),
                                  // Adjust button style as needed
                                  backgroundColor:
                                      const Color.fromARGB(255, 3, 102, 184),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 15),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ),
                            SizedBox(height:screenHeight*0.02),
                            Row(
                              children: [
                                Container(
                                  color: Colors.grey, // Color of the line
                                  width: 40.0, // Width of the line (2cm)
                                ),
                                Center(
                                    child: Text("-----Or SignIn With-----",
                                        style: TextStyle(fontSize: baseFontSize))),
                                Container(
                                  color: Colors.grey, // Color of the line
                                  width: 40.0, // Width of the line (2cm)
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Center(
                              child:IconButton(
                        icon: FaIcon(FontAwesomeIcons.google),
                        onPressed:()async{
                          await _auth.signInWithGoogle();
                                }
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: paddingValue),
              ],
            ),
          ),
        ],
      );
    });
  }
}
