import 'package:flutter/material.dart';
import 'package:project_login/ViewModels/HomeStoryViewModel.dart';
import 'package:project_login/ViewModels/SearchStoryViewModel.dart';
import 'package:project_login/Views/HomeStoryView.dart';
import 'package:provider/provider.dart';
import 'ViewModels/DetailStoryViewModel.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SearchStoryViewModel()),
        ChangeNotifierProvider(create: (context) => DetailStoryViewModel()),
        ChangeNotifierProvider(create: (context) => HomeStoryViewModel())
      ],
      child: MaterialApp(
        title: 'Story App',
        home: HomeScreen(),
      ),
    );
  }
}