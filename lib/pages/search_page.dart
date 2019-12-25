import 'package:flutter/material.dart';
import 'package:flutter_trip/widget/searchNavBar.dart';


class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override

 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('搜索'),
        // textTheme: ,
      ),
       body: Column(
      
         children: <Widget>[
           SearchNavBarWidget(
             hideLeft: true,
             defalutTip: '哈哈',
             defaultText: '呵呵',
             leftButtonOnClick: (){
                print('leftButtonOnClick');
             },
             rightButtonOnClick: (){
                print('rightButtonOnClick');
             },
             speakClick: (){
                print('speakClick');

             },
             inputBoxClick: (){

               print('inputBoxClick');

             },

           )
         ],
       ),
    );
  }
}
