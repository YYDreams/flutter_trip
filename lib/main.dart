import 'package:flutter/material.dart';
import 'package:flutter_trip/tab_navigator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var materialApp = MaterialApp(
      
      debugShowCheckedModeBanner: true,
      title: 'Flutter Demo',
      theme: ThemeData(
    
        primarySwatch: Colors.blue,
      ),
      home: TabNavigator(),
    );
    return materialApp;
  }
}

