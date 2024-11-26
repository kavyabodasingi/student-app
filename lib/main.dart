import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:student/firebase_options.dart';
import 'package:student/home.dart';

void main() async{
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // theme:ThemeClass.lightTheme,
      // darkTheme: ThemeClass.darkTheme,
      home:Home(),
    );
  }
}