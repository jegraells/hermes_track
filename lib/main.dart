import 'package:flutter/material.dart';
import 'package:hermes_track/screens/login_screen.dart';


void main() {
  runApp(HermesTrackApp());
}

class HermesTrackApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hermes Track',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(), // Use LoginScreen here
    );
  }
}

