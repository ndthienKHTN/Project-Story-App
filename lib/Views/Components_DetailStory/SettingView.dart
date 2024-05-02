import 'package:flutter/material.dart';
import 'package:project_login/ViewModels/HomeStoryViewModel.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: <Widget>[
            Container(
                alignment: AlignmentDirectional.topCenter,
                child: const Text('List Source Book',style: TextStyle(
                  fontSize: 40,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),)),
            const Expanded(
              child: SortSourceBook(),
            )
          ],
        )
    );
  }
}




class SortSourceBook extends StatefulWidget {
  const SortSourceBook({super.key});

  @override
  State<SortSourceBook> createState() => _SortSourceBookState();
}

class _SortSourceBookState extends State<SortSourceBook> {

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeStoryViewModel>(
      builder: (context, sourceBookNotifier, _) {
        return ReorderableListView(
          children: List.generate(
            sourceBookNotifier.sourceBooks.length,
                (index) => Container(
              key: Key('$index'),
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              margin: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.red,width: 6),
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white
              ),
              child: ListTile(
                title: Text(
                  sourceBookNotifier.sourceBooks[index],
                  style: const TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          onReorder: (int oldIndex, int newIndex) {
            sourceBookNotifier.Reorder(oldIndex, newIndex);
            sourceBookNotifier.ChangeIndex(0);
            sourceBookNotifier.ChangeSourceBook(sourceBookNotifier.sourceBooks[0]);
            sourceBookNotifier.fetchHomeStories(sourceBookNotifier.sourceBooks[0]);
          },
        );
      },
    );
  }
}