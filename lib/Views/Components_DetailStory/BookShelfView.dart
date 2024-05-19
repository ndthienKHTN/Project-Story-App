import 'package:flutter/material.dart';

class BookShelfPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
  bool _isBtnHistoryPressed = false;
  bool _isBtnDownloadPressed = false;
  Widget _currentData = Text('Example');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
               Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                      onPressed: (){
                        setState(() {
                          _isBtnHistoryPressed = true;
                          _isBtnDownloadPressed = false;
                          _currentData = SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: MyCustomWidget(),
                            ),
                          );
                        });
                      },
                      child: Text(
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _isBtnHistoryPressed ? Colors.red : Colors.white,
                            fontSize: 25,
                          ),
                          'Lịch sử'
                      )
                  ),

                  SizedBox(
                    width: 30,
                  ),
                  TextButton(
                      onPressed: (){
                        setState(() {
                          _isBtnDownloadPressed = true;
                          _isBtnHistoryPressed = false;
                          _currentData = SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: MyCustomWidget(),
                            ),
                          );
                        });
                      },
                      child: Text(
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _isBtnDownloadPressed ? Colors.red : Colors.white,
                            fontSize: 25,
                          ),
                          'Tải xuống'
                      )
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              MyCustomWidget(),
              Divider(color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
class MyCustomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.yellow, // Màu của đường viền
                width: 2.5, // Độ rộng của đường viền
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                  'assets/images/naruto.jpg'
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Wonder Lab (Labotomy Corp)",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                "By: ",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                "Đã đọc đến chương:  ",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}