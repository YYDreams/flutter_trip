import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/network/network.dart';
import 'package:flutter_trip/pages/search_page.dart';
import 'package:flutter_trip/widget/gridNav.dart';
import 'package:flutter_trip/widget/localNav.dart';
import 'package:flutter_trip/widget/salesBox.dart';
import 'package:flutter_trip/widget/searchNavBar.dart';
import 'package:flutter_trip/widget/subNav.dart';
import 'package:flutter_trip/widget/loading_container.dart';
const APPBAR_SCROLL_OFFSET = 100;
const kDefaultText = '网红打卡地 景点 酒店 美食';
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

          
          child:  
          
          _listView),),),
          _appBar,
        ],
      ),
    )
    );

  }

//设置AppBar
Widget get _appBar{

            // final double topPadding = MediaQuery.of(context).padding.top;
            //  final double bottomPadding = MediaQuery.of(context).padding.bottom;
            // print(topPadding); //打印：iphoneX 44  其他尺寸的打印：20
            // print(bottomPadding); //打印：iphoneX 0 其他尺寸的打印：0
  return Column(
    
      children: <Widget>[
        Container(

          child: Container(
  
            padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).padding.top, 0, 0),
            height: 80,
            decoration: BoxDecoration(
              color: Color.fromARGB((navAlpha * 255).toInt()  , 255, 255, 255),),
              child: _search,

          ),

        ),
        Container(
          height: navAlpha > 0.2 ? 0.5 : 0,
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)],
          ),
        )
      ],
  );

 

}

Widget get _search{

return Column(
      
         children: <Widget>[
           SearchNavBarWidget(
               defalutTip: 'ddd',
               defaultText: kDefaultText,
               city: '深圳市',



              //滚动的时候改变城市的字体颜色以及右边按钮图标颜色
               searchBarType: navAlpha > 0.2
                  ? SearchBarType.homeLight
                  : SearchBarType.home,
              // speakClick: _jumpToSearch,
              speakClick: _jumpToSpeakAction,
              // defaultText: SEARCH_BAR_DEFAULT_TEXT,
              leftButtonOnClick: _jumpToCityAction,
              inputBoxClick: _jumpToSearchAction,
              rightButtonOnClick: _jumpToMessageAction,
            ),

          //    hideLeft: true,
          //    defalutTip: '哈哈',
          //    defaultText: '呵呵',
          //    leftButtonOnClick: (){
          //       print('leftButtonOnClick');
          //    },
          //    rightButtonOnClick: (){
          //       print('rightButtonOnClick');
          //    },
          //    speakClick: (){
          //       print('speakClick');

          //    },
          //    inputBoxClick: (){

          //      print('inputBoxClick');

          //    },

          //  )
         ],
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


//SEL Actions
_jumpToCityAction(){

print('跳转选择地址');

}
_jumpToSearchAction(){
  print('跳转搜索页面');
  Navigator.push(context, MaterialPageRoute(
    builder: (context){

      return SearchPage(defalutTip: kDefalutTip,hideLeft: false,);

    }
  ));




}
_jumpToSpeakAction(){
   print('跳转语音');

}

_jumpToMessageAction(){
  print('跳转消息页面');
}


}