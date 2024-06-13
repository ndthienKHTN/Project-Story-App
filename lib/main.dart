import 'package:flutter/material.dart';

<<<<<<< HEAD
import 'Views/ReadOfflineFile.dart';
=======
>>>>>>> origin/Thien_Developer
import 'Views/SplashView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Story App',
      home: SplashScreen(),
      //home: ReadOfflineFile()
    );
  }
}
