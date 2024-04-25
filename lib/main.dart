import 'package:flutter/material.dart';
import 'package:project_login/ViewModels/HomeStoryViewModel.dart';
import 'package:project_login/ViewModels/SearchStoryViewModel.dart';
import 'package:project_login/Views/MainView.dart';
import 'package:provider/provider.dart';
import 'ViewModels/DetailStoryViewModel.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SearchStoryViewModel()),
        ChangeNotifierProvider(create: (context) => DetailStoryViewModel()),
        ChangeNotifierProvider(create: (context) => HomeStoryViewModel()),

      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Story App',
        home: MainPage(),
      ),
    );
  }
}