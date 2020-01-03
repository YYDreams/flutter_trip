import 'package:flutter/material.dart';
import 'package:flutter_trip/tab_navigator.dart';

void main() => runApp(MyApp());


   //无状态控件：不需要有自己的私有数据 纯展示型数据
   // 有状态控件：网络请求

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

