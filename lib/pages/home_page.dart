import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/network/network.dart';
import 'package:flutter_trip/widget/gridNav.dart';
import 'package:flutter_trip/widget/localNav.dart';
import 'package:flutter_trip/widget/salesBox.dart';
import 'package:flutter_trip/widget/subNav.dart';
import 'package:flutter_trip/widget/loading_container.dart';
const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //定义变量
  double navAlpha = 0;  //设置导航栏的默认值
  List<CommonModel> bannerList = []; //banner数据
  List<CommonModel> localNavList = []; //local导航
  GridNav gridNavModel ; //
  List<CommonModel> subNavList= [];
  SalesBox salesBoxModel; //底部网格数据
  bool _loading = true; //

@override
//初始化方法
void initState() { 
  super.initState();
  _handlerRefresh();

  
}
_onScroll(offset){
  double alpha  = offset / APPBAR_SCROLL_OFFSET;
    if(alpha < 0) {
     alpha = 0;

    }else if(alpha > 1){
      alpha = 1;
    }
    setState(() {
      navAlpha = alpha;
    });
  // print('navAlpha:$navAlpha');

}

//请求数据
  Future<Null> _handlerRefresh() async{
    try{ 
    HomeModel model = await NetworkRequest.homeDataFromNetwork();
        
    setState(() {
     localNavList = model.localNavList;
     gridNavModel = model.gridNav;
     subNavList = model.subNavList;
     salesBoxModel = model.salesBox;
     bannerList = model.bannerList;
     _loading = false;
   });

    }catch(error){

      setState(() {
        
        _loading = false;
      });
       print('请求异常');

    }
  return null;
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor:Color(0xfff2f2f2) ,
      body: LoadingContainer(isLoading: _loading,child: Stack(
        children: <Widget>[
          MediaQuery.removePadding( //置顶 默认会有个状态栏的距离
            removeTop: true,
            context: context,
            child:RefreshIndicator(onRefresh: _handlerRefresh,
            child:  NotificationListener( //监听列表滚动
               onNotification: (scrollNotification){

           if (scrollNotification is ScrollUpdateNotification && scrollNotification.depth == 0 ){ // scrollNotification.depth == 0 就是ListView

           _onScroll(scrollNotification.metrics.pixels);

           }
          return false;

         },
          child:  _listView),),),
          _appBar,
        ],
      ),
    )
    );

  }

//设置AppBar
Widget get _appBar{

  return  Opacity(
            opacity: navAlpha,
            child: Container(
              height: 64,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Padding(padding:EdgeInsets.only(top: 20),
                child: Text('首页',style:TextStyle(
                  fontSize: 20,
                ) ,),
                ),
              ),
            ),
          ); 

}

  //设置UI
Widget get _listView{

    return  ListView(
            
          children: <Widget>[
            Container(
            height: 200,
            
            child: Swiper(
                onTap: (index){
                  // print(index);
                },
                itemCount: bannerList.length, //图片总数
                 autoplay: true, //是否自动播放
                itemBuilder: (BuildContext content,int index){
                return Image.network(bannerList[index].icon,fit: BoxFit.fill,);
                },
                pagination: SwiperPagination(), //指示器

              ),
             ),
             
             //funcation
            Padding(
              padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
              child:LocalNavWidget(localNavList: localNavList),

             ),
               Padding(
                 //外面设置间隙 
              padding: EdgeInsets.fromLTRB(8, 0, 8, 4),
              child: GirdNavWidget(gridNavModel: gridNavModel),

             ),
            
            Padding(
               padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
                child: SubNavWidget(subNavList:subNavList),
            ),

              Padding(
               padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
                child: SaledBoxWidget(salesBoxModel:salesBoxModel),
            ),
          ],
        );
  }
}