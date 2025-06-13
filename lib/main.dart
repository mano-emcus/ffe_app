import 'package:ffe_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return SafeArea(  
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FFE App',
        home: const SplashScreen(),
      ),
    );
  }
}


