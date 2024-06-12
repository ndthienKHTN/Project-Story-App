import 'dart:io';

import 'package:flutter/material.dart';

class ReadOfflineFile extends StatefulWidget{
  const ReadOfflineFile({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ReadOfflineFileState();
  }
}

class _ReadOfflineFileState extends State<ReadOfflineFile> {
  String fileContent = '';
  String path = '/storage/emulated/0/Android/data/com.example.project_login/files/DownloadedFile/9891_1.txt';

  @override
  void initState() {
    super.initState();
    _readFileContent();
  }

  Future<void> deleteFile(String filePath) async {
    try {
      final file = File(filePath);

      if (await file.exists()) {
        await file.delete();
        print('File đã được xóa: $filePath');
      } else {
        print('File không tồn tại: $filePath');
      }
    } catch (e) {
      print('Lỗi khi xóa file: $e');
    }
  }

  Future<void> _readFileContent() async {
    try {
      final file = File(path);
      String content = await file.readAsString();
      setState(() {
        fileContent = content;
      });
    } catch (e) {
      print('Error reading file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset('assets/images/back_icon.png'), // Icon bên trái
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white,),
            onPressed: () async {
              await deleteFile(path);
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            },
          ),
        ],
        title: Text(
          'Title',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background_home.png'),
                  fit: BoxFit.fill)),
          child: SafeArea(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
                color: Colors.white
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(fileContent, style: TextStyle(fontSize: 20),),
                ),
              )
            ),
          )),
    );
  }
}