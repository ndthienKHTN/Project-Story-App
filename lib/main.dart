import 'package:flutter/material.dart';
import 'login_view.dart';
import 'register_view.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SearchStoryViewModel()),
        ChangeNotifierProvider(create: (context) => DetailStoryViewModel()),
        ChangeNotifierProvider(create: (context) => HomeStoryViewModel())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Story App',
        home: MainPage(),
      ),
      home: LoginPage(),
    );
  }
}

