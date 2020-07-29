import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tricktok/screens/VideoScreen.dart';

void main() => runApp(MainPage());

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TrickTok',
      theme: ThemeData.dark(),
      home: VideoScreen(),
    );
  }
}
