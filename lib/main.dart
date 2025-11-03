import 'package:flutter/material.dart';
import 'home.dart';

// run app
void main() {
  runApp(const PrepPortalApp());
}

// PrepPortalApp widget
class PrepPortalApp extends StatelessWidget {
  const PrepPortalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prep Portal',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainScreen(), // home screen
    );
  }
}
