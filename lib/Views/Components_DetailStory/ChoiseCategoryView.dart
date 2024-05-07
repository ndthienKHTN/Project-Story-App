import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_login/Models/Category.dart';
import 'package:provider/provider.dart';

import '../../ViewModels/ChoiseCategoryViewModel.dart';

class ChoiseCategoryScreen extends StatefulWidget {
  final String category;
  final String datasource;
  const ChoiseCategoryScreen({super.key,required this.datasource,required this.category});
  @override
  State<ChoiseCategoryScreen> createState() => _ChoiseCategoryScreenState();
}

class _ChoiseCategoryScreenState extends State<ChoiseCategoryScreen> {
  late ChoiseCategoryViewModel _choiseCategoryViewModel;
  String categorynew='';

  @override
  void initState() {
    super.initState();
    _choiseCategoryViewModel=Provider.of<ChoiseCategoryViewModel>(context,listen: false);
    _choiseCategoryViewModel.fetchCategories(widget.datasource);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Colors.black
              ),
            ),
            SafeArea(
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 85),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.redAccent
                        ),
                        child:  const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.category,size: 28,color: Colors.white,),
                              Text("Thể Loại",style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ))
                            ]
                        ),
                      ),
                      Expanded(
                          child: Consumer<ChoiseCategoryViewModel>(
                            builder: (context,sourceNotify,_) {
                              List<Category>? categories=sourceNotify.categories;
                              return GridView.builder(
                                  itemCount: categories!.length,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, // Số lượng cột trong grid view
                                    mainAxisSpacing: 1, // Khoảng cách giữa các hàng
                                  ),
                                  itemBuilder: (context,index){
                                    return Container(
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                                      child: Text(categories[index].content,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          overflow: TextOverflow.ellipsis,
                                          color: Colors.white,
                                        ),),
                                    );
                                  }
                              );
                            },))
                    ],
                  ),
                )
            )
          ],
        )
    );
  }
}
