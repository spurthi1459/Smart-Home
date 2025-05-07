import 'package:flutter/material.dart';
import 'login_page.dart'; // <-- instead of chatbot.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(), // <-- Show login page first
    );
  }
}

