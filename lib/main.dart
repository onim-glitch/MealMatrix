
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const SmartRestaurantApp());
}

class SmartRestaurantApp extends StatelessWidget {
  const SmartRestaurantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Restaurant',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}
