import 'package:flutter/material.dart';
import 'package:project_login/ViewModels/SearchStoryViewModel.dart';
import 'package:provider/provider.dart';
import 'Models/Story.dart';
import 'ViewModels/DetailStoryViewModel.dart';
import 'Views/DetailStoryView.dart';
import 'Views/SearchStoryView.dart';
import 'login_view.dart';
import 'register_view.dart';
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
      ],
      child: MaterialApp(
        title: 'Story App',
        home: SearchScreen(),
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
      title: 'MVVM Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('MVVM Flutter App'),
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () => _storyViewModel.fetchStory(),
              child: Text('Fetch Stories'),
            ),
            Expanded(
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
                                builder: (context) => StoryDetailScreen(storyTitle: 'need to change later'),
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
          ],
        ),
      ),
    );
  }
}*/

