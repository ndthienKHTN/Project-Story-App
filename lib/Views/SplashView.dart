import 'package:flutter/material.dart';
import 'package:project_login/ViewModels/DownloadChaptersViewModel.dart';
import 'package:provider/provider.dart';

import '../../ViewModels/DetailStoryViewModel.dart';
import '../../ViewModels/HomeStoryViewModel.dart';
import '../../ViewModels/SearchStoryViewModel.dart';
import '../ViewModels/ReadingHistoryViewModel.dart';
import 'MainView.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async{
    await Future.delayed(const Duration(milliseconds: 1500),(){});
    Navigator.pushReplacement(context,MaterialPageRoute(
        builder: (context)=>MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => SearchStoryViewModel()),
            ChangeNotifierProvider(create: (context) => DetailStoryViewModel()),
            ChangeNotifierProvider(create: (context) => HomeStoryViewModel()),
            ChangeNotifierProvider(create: (context) => ReadingHistoryViewModel()),
          ],
          child: MainPage()
        )
    )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: Image.asset('assets/images/Splash.png',height: 300,)),
    );
  }
}

