import 'package:flutter/material.dart';
 import 'package:fluttertoast/fluttertoast.dart';
class MinePage extends StatefulWidget {
  MinePage({Key key}) : super(key: key);

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: _setupNavAppBar, 
      drawer: _setupDrawer,

       
    );
  }

  Widget get _setupNavAppBar{

    return AppBar(
        title: Text('我的'),
        actions: <Widget>[
          IconButton(  //nav abbBar right button
            icon: Icon(Icons.settings),
            onPressed: (){
              print('设置');
            },
          )

        ],
      );
  }

  Widget get _setupDrawer{
      
      final List titleArr = ['个人资料','我的收藏','我的订单','收货地址']; 
      

    return Drawer(  //侧边栏
        child: ListView(
          
          children: <Widget>[
            //渲染 headerIcon/name/email
            UserAccountsDrawerHeader(
              accountName: Text("flowerflower"),
              accountEmail: Text("https://www.jianshu.com/u/1e1b009ae780"),
              currentAccountPicture: CircleAvatar(backgroundImage: NetworkImage('https://upload-images.jianshu.io/upload_images/1658521-a34fe31f7d0dc727.png?imageMogr2/auto-orient/strip|imageView2/2/w/1188')),
              
              //美化当前控件的
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage("https://upload-images.jianshu.io/upload_images/1658521-d47e88ef9351e93d.jpg?imageMogr2/auto-orient/strip|imageView2/2/w/500"),

                )
              ) ,
            ),

            //      data['extension'] = this.extension.map((v) => v.toJson()).toList();
  
          //  titleArr.map((index)=>{});
       
            ListTile(
            title: Text("个人资料"),trailing: Icon(Icons.info),
              onTap: (){
                print("object");
     
              },
            ),
            Divider(),
             ListTile(
              title: Text("我的收藏"),trailing: Icon(Icons.linked_camera),
            ),
            Divider(),
             ListTile(
              title: Text("我的订单"),trailing: Icon(Icons.rv_hookup),
            ),
            Divider(),
             ListTile(
              title: Text("收货地址"),trailing: Icon(Icons.timeline),
            ),
            Divider(),
              ListTile(
              title: Text("退出"),trailing: Icon(Icons.remove_circle),
            ),
            Divider(),


          ],
        ),
      );
       
       
  }
}
