import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class DownloadChapters extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,size: 30,color: Colors.white,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.black,
        title:Padding(
          padding: EdgeInsets.only(top: 6),
          child: Center(
            child: Text("Chọn chương để tải về",style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Colors.white,
          ),
          ),
          ),
        ) ,
      ),
      body: BodyWidget(),
    );
  }
}
class BodyWidget extends StatefulWidget {
  const BodyWidget({super.key});
  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}
class _BodyWidgetState extends State<BodyWidget> {
  final int buttonsPerRow = 3;
  int numberOfButtons = 16;
  late Map<int, bool> selectedButtons;
  bool _isCheckAll = false;
  @override
  void initState() {
    super.initState();
    selectedButtons = Map.fromIterable(
      List.generate(numberOfButtons, (index) => index + 1),
      key: (item) => item,
      value: (item) => false,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/background_home.png',
                ),
                fit: BoxFit.cover,
              )
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Tổng số chương: ${numberOfButtons}',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            top: 50.0,
            left: 20.0,
            right: 20.0,
              bottom: 50,
              child: GridView.builder(
                  itemCount: numberOfButtons,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: buttonsPerRow,
                    mainAxisSpacing: 20.0,
                    crossAxisSpacing: 20.0,
                    childAspectRatio: 100 / 40,
                  ),
                  itemBuilder: (BuildContext,int index){
                    return ElevatedButton(
                      onPressed: (){
                        setState(() {
                          selectedButtons[index+1] = !selectedButtons[index+1]!;
                        });
                      },
                      child: Text(
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          '${index+1}'
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedButtons[index+1]! ? Colors.blue : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),

                      ),
                    );
                  }
              ),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: BottomAppBar(
                  child: Row(
                    children: <Widget>[
                      Checkbox(
                          value: _isCheckAll,
                          onChanged: (bool ?value){
                            setState(() {
                              _isCheckAll = value!;
                              if(_isCheckAll){
                                selectedButtons = Map.fromIterable(
                                  List.generate(numberOfButtons, (index) => index + 1),
                                  key: (item) => item,
                                  value: (item) => true,
                                );
                              }
                              else{
                                selectedButtons = Map.fromIterable(
                                  List.generate(numberOfButtons, (index) => index + 1),
                                  key: (item) => item,
                                  value: (item) => false,
                                );
                              }
                            });
                          }
                      ),
                      Text(
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                          'Chọn tất cả'
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      VerticalDivider(
                        color: Colors.black ,
                        thickness: 2,
                        width: 20,
                        indent: 10,
                        endIndent: 10,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      IconButton(
                          onPressed: (){

                          },
                          icon: Icon(Icons.download)
                      ),
                      Text(
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        'Tải xuống'
                      )
                    ],
                  ),
          ))


        ],
    );
  }

}