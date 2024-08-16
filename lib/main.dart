import 'package:flutter/material.dart';
import 'package:salon_app/starting_screens/SpalshScreen.dart';

Future<void> main() async {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash_Screen_Screen(),
    ),
  );
}
