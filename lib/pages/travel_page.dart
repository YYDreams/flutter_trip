
import 'package:flutter/material.dart';
import 'package:flutter_trip/model/travel_tab_model.dart';
import 'package:flutter_trip/network/network.dart';
import 'package:flutter_trip/pages/travel_tab_page.dart';


class TravelPage extends StatefulWidget {
  TravelPage({Key key}) : super(key: key);

  @override
  _TravelPageState createState() => _TravelPageState();
}


//with XXX  必须实现
//    将SingleTickerProviderStateMixin换成TickerProviderStateMixin
class _TravelPageState extends State<TravelPage>  with TickerProviderStateMixin{


//定义属性
TabController _controller;
List<Tabs> tabs = [];
TravelTabModel travelTabModel;

@override
void initState() { 
  _loadData();
  super.initState();
  
}
@override
  void dispose() {
    //页面销毁的时候  释放_controller
    _controller.dispose();
    super.dispose();
  }
void _loadData() async{

  //进入头文件进行查看  @required TickerProvider vsync 
    _controller = TabController(length: 0, vsync: this);

      try{

       TravelTabModel model = await NetworkRequest.travelTabDataFromNetwork();

       _controller = TabController(length: model.tabs.length,vsync: this);

        setState(() {
          
          tabs = model.tabs;
          travelTabModel = model;

        });
      }catch(error){

      print(error);

      }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: <Widget>[

            Container(
             color: Colors.white,
             padding: EdgeInsets.only(top: 30),
             child: TabBar(
               controller: _controller,
               isScrollable:  true,
               labelColor: Colors.black,
               labelPadding: EdgeInsets.fromLTRB(20, 0, 10 , 5),
               indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.red,width: 3),
                insets: EdgeInsets.only(bottom: 10)),
             
                tabs: tabs.map<Tab>((Tabs tab){
                return Tab(
                  text: tab.labelName,
                );
               }).toList(),
             ),
           ),

           // Flexible解决 Horizontal viewport was given unbounded height.报错
           Flexible(
             child: TabBarView(
             controller: _controller,
             children: tabs.map((Tabs tab){
               return TravelTabPage(travelUrl:travelTabModel.url,
                                    params: travelTabModel.params ,
                                    groupChannelCode: tab.groupChannelCode,
                                    type:tab.type ,
                                    );
            
             }).toList(),
           ) ,
           )
          

        ],
      ),


    ) ;
  }
}