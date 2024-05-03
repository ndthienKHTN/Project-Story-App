import 'package:flutter/material.dart';
import 'package:project_login/Views/HomeStoryView.dart';
import 'package:project_login/Views/MainView.dart';
import 'package:provider/provider.dart';
import 'ViewModels/ContentStoryViewModel.dart';
import 'ViewModels/DetailStoryViewModel.dart';
import 'ViewModels/HomeStoryViewModel.dart';
import 'ViewModels/SearchStoryViewModel.dart';
import 'Views/ContentStoryView.dart';
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
        ChangeNotifierProvider(create: (context) => HomeStoryViewModel()),
        //ChangeNotifierProvider(create: (context) => ContentStoryViewModel()) //để tạm
      ],
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Story App',
        home: HomeScreen(),//MainPage(),
        //home: ContentStoryScreen(storyTitle: 'choc-tuc-vo-yeu-mua-mot-tang-mot', chap: '10'),
      ),

    );
  }
}

