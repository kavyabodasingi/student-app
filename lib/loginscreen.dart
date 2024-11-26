import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:student/homeScreen.dart';
import 'package:student/signup.dart';

import 'Authentication/auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool passwordObsecured = true;
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double baseFontSize = screenWidth * 0.054;
    return Scaffold(
      appBar: AppBar(
        
        title: Text(
          "LoginScreen",
          style: TextStyle(color: Colors.white,fontSize:baseFontSize ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Body(),
    );
  }

  Widget Body() {
    final _auth=AuthService();
    final Color backgroundColor = Theme.of(context).colorScheme.background;
    final Color containerColor = Theme.of(context).colorScheme.surface;
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double screenHeight = constraints.maxHeight;
        double paddingValue = screenHeight * 0.2;
        double baseFontSize = screenWidth * 0.05;
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  filterQuality: FilterQuality.low,
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/Online-Attendance-Management-System.png"),
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
            SingleChildScrollView(
              
              child: Column(
                children: [
                  SizedBox(height: paddingValue,),
                  Align(
                    
                    alignment: Alignment.center,
                    child: FractionallySizedBox(
                      widthFactor: 0.9,
                      child: Container(
                        color: containerColor.withOpacity(0.6),
                        width: screenWidth * 0.9,
                        padding: EdgeInsets.all(20.0),
                        // decoration: BoxDecoration(
                        //   color: Colors.white.withOpacity(0.6),
                        //   borderRadius: BorderRadius.circular(20),
                        // ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please Enter Email Address";
                                    }
                                    return null;
                                  },
                                  controller: email,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    hintText: "Enter Email Address",
                                    label: Text("Email Address",style: TextStyle(fontSize:baseFontSize ),),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      gapPadding: 4.0,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please Enter Password";
                                    }
                                    return null;
                                  },
                                  obscureText: passwordObsecured,
                                  controller: password,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          passwordObsecured = !passwordObsecured;
                                        });
                                      },
                                      icon: Icon(passwordObsecured
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                    ),
                                    hintText: "Enter Password",
                                    label: Text("Password",style: TextStyle(fontSize:baseFontSize )),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      gapPadding: 4.0,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              ElevatedButton(
                                onPressed: () {

                                  if (_formKey.currentState!.validate()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("Logged In Successfully",style: TextStyle(fontSize:baseFontSize )),
                                        backgroundColor: Colors.green,
                                        duration: Duration(milliseconds: 1500),
                                      ),
                                    );
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomeScreen(userEmail: email.toString(),)));
                                    return;
                                    
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            "Email or Password Must Not Be Empty",style: TextStyle(fontSize:baseFontSize )),
                                        backgroundColor: Colors.red,
                                        duration: Duration(milliseconds: 1500),
                                      ),
                                    );
                                    return;
                                  }
                                },
                                child: Text(
                                  "SignIn",
                                  style: TextStyle(color: Colors.white,fontSize:baseFontSize,),
                                ),
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(screenWidth*0.75, screenHeight*0.08),
                                  backgroundColor: Color.fromARGB(255, 85, 27, 245),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 15),
                                ),
                                
                              ),
                              SizedBox(height: 20),
                              Column(
                                children: [
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Don't Have an Account?",style: TextStyle(fontSize:screenWidth*0.035)),
                                      SizedBox(width:6),
                                      Expanded(
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => SignUp()));
                                          },
                                          child: Text(
                                            "SignUp Here",
                                            style: TextStyle(color: Color.fromARGB(255, 30, 61, 233),fontSize:screenWidth*0.035),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Center(
                                    child: Row(
                                      children: [
                                        Container(
                                          color: Colors.grey, // Color of the line
                                          width: 40.0, // Width of the line (2cm)
                                        ),
                                        Text("-----Or SignIn With-----",style: TextStyle(fontSize:screenWidth*0.035 )),
                                        Container(
                                        color: Colors.grey, // Color of the line
                                        width: 40.0, // Width of the line (2cm)
                                      ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Center(
                                    child:IconButton(
                                      onPressed: ()async{
                                        await _auth.signInWithGoogle();

                                      },
                                      icon:FaIcon(
                                        FontAwesomeIcons.google
                                      )
                                    )
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}