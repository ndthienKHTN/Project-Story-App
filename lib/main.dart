import 'package:flutter/material.dart';
import 'package:project_login/ViewModels/ContentStoryViewModel.dart';
import 'package:project_login/ViewModels/HomeStoryViewModel.dart';
import 'package:project_login/ViewModels/SearchStoryViewModel.dart';
import 'package:project_login/Views/ContentStoryView.dart';
import 'package:provider/provider.dart';

import 'ViewModels/DetailStoryViewModel.dart';
import 'Views/Components/ChooseChapterBottomSheet.dart';
import 'Views/HomeStoryView.dart';
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
        ChangeNotifierProvider(create: (context) => HomeStoryViewModel()),
        //ChangeNotifierProvider(create: (context) => ContentStoryViewModel()) //để tạm
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Story App',
        //home: ContentStoryScreen(storyTitle: 'choc-tuc-vo-yeu-mua-mot-tang-mot',),
         home: HomeScreen(),
      ),
    );
  }
}
/*class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DetailStoryViewModel(),
      child: MaterialApp(
        title: 'Story App',
        home: StoryListScreen(),
      ),
    );
  }
}*/

/*class StoryListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _storyViewModel = Provider.of<StoryViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Story List'),
      ),
      body: Expanded(
        child: StreamBuilder<List<Story>>(
          stream: _storyViewModel.storyStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final stories = snapshot.data;
              return ListView.builder(
                itemCount: stories?.length,
                itemBuilder: (context, index) {
                  final story = stories?[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                            create: (context) => DetailStoryViewModel(),
                            child: StoryDetailScreen(storyTitle: 'need to change'),
                          ),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text(story!.name),
                      subtitle: Text('Cover: ${story?.cover}'),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error');
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}*/
/*class MyApp extends StatelessWidget {
  final StoryViewModel _storyViewModel = StoryViewModel();
  //const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

