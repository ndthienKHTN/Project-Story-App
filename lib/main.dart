import 'package:flutter/material.dart';
import 'package:project_login/Views/HomeStoryView.dart';
import 'package:project_login/Views/MainView.dart';
import 'package:provider/provider.dart';
import 'ViewModels/DetailStoryViewModel.dart';
import 'ViewModels/HomeStoryViewModel.dart';
import 'ViewModels/SearchStoryViewModel.dart';
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
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Story App',
        home: HomeScreen(),//MainPage(),
      ),

    );
  }
}

