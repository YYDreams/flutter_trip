import 'package:flutter/material.dart';
import 'package:flutter_trip/pages/home_page.dart';
import 'package:flutter_trip/pages/mine_page.dart';
import 'package:flutter_trip/pages/search_page.dart';
import 'package:flutter_trip/pages/test_page.dart';
import 'package:flutter_trip/pages/travel_page.dart';

class TabNavigator extends StatefulWidget{
  @override
  _TabNavigatorState createState()  => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator>{
final _defaultColor = Colors.black;
final _selectedColor = Colors.red;
final PageController _controller = PageController(
   initialPage: 0,
);
int _currentIndex = 0; //记录当前选中的index
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
       body: PageView(
         controller:  _controller,
         children: <Widget>[
            HomePage(),
            SearchPage(),
            MinePage(),
            TestPage(),
            TravelPage(),
         ],
       ),
       
       bottomNavigationBar: BottomNavigationBar(
         currentIndex: _currentIndex,
         onTap: (index){
           _controller.jumpToPage(index);
           setState(() {
              _currentIndex = index;

           });
         },

        type: BottomNavigationBarType.fixed, //图片和文字都显示
        
         items: [
         BottomNavigationBarItem(
           icon: Icon(Icons.home, color: _defaultColor),
           activeIcon:Icon(Icons.home, color: _selectedColor),  
           title: Text("首页", style:TextStyle(
             color: _currentIndex != 0? _defaultColor : _selectedColor,
           )),
         ),

         BottomNavigationBarItem(
           icon: Icon(Icons.search, color: _defaultColor),
           activeIcon:Icon(Icons.search, color: _selectedColor),  
           title: Text("搜索", style:TextStyle(
             color: _currentIndex != 1? _defaultColor : _selectedColor,
           )),
         ),
           BottomNavigationBarItem(
           icon: Icon(Icons.camera_alt, color: _defaultColor),
           activeIcon:Icon(Icons.camera_alt, color: _selectedColor),  
           title: Text("旅拍", style:TextStyle(
             color: _currentIndex != 2? _defaultColor : _selectedColor,
           )),
         ),
           BottomNavigationBarItem(
           icon: Icon(Icons.account_circle, color: _defaultColor),
           activeIcon:Icon(Icons.account_circle, color: _selectedColor),  
           title: Text("我的", style:TextStyle(
             color: _currentIndex != 3? _defaultColor : _selectedColor,
           )),
         ),
       ]
       ),
    );

  }

}