import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/network/network.dart';
import 'package:flutter_trip/widget/localNav.dart';

const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //定义变量
List _images = [
  'https://upload.jianshu.io/admin_banners/web_images/4838/fb1f935e01480f9ab450fab97c9e147952a2c37f.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/1250/h/540',
  'https://upload-images.jianshu.io/upload_images/1658521-734e1af1f812a83a.png?imageMogr2/auto-orient/strip|imageView2/2/w/704',
  'https://upload-images.jianshu.io/upload_images/1658521-112e5c8f935a7231.jpg?imageMogr2/auto-orient/strip|imageView2/2/w/620',
];
double navAlpha = 0;  //设置导航栏的默认值

String resultString = '1234';
  List<LocalNavList> localNavList = []; //local导航



@override
//初始化方法
void initState() { 
  super.initState();
  loadData();

  
}
_onScroll(offset){
  //动态设置
  print(offset);
  print('offset:$offset');

  double alpha  = offset / APPBAR_SCROLL_OFFSET;
    if(alpha < 0) {
     alpha = 0;

    }else if(alpha > 1){
      alpha = 1;
    }
    setState(() {
      navAlpha = alpha;
    });
  print('navAlpha:$navAlpha');

}

//请求数据
  loadData() async{


    try{ 
      print('========');
    HomeModel model = await NetworkRequest.homeDataFromNetwork();
        

    setState(() {
     localNavList = model.localNavList;
     print(model.localNavList);
     resultString = json.encode(model.localNavList);


   });

    }catch(error){
      resultString = '请求异常';
       print('请求异常');
    }

    //方式一：
    // HomeDao.fetch().then((result){
    // setState(() {
    //   resultString = json.encode(result);//将result进行转换
    // });

    // }).catchError((error){
    //   print('请求异常');
    //   resultString = error.toString();

    // });

    // try{


  

    // }catch(error){
    //   print('请求异常');
    // }
    //方式2：

//     // try{
//       HomeModel model = await HomeDao.fetch();
//       setState(() {
//         resultString = json.encode(model);
//         localNavList = model.localNavList;

//  print('ocalNavList$localNavList');


//       });
    // }catch(error){
    //     resultString = "请求出错";

    //   print('请求异常');
    
    
    // }

  }



  @override
  Widget build(BuildContext context) {
    loadData();
    return Scaffold(
      backgroundColor:Color(0xfff2f2f2) ,
      body: Stack(
        children: <Widget>[
          MediaQuery.removePadding( //置顶 默认会有个状态栏的距离
            removeTop: true,
            context: context,
            child: NotificationListener( //监听列表滚动
        
         onNotification: (scrollNotification){

           if (scrollNotification is ScrollUpdateNotification && scrollNotification.depth == 0 ){ // scrollNotification.depth == 0 就是ListView

           _onScroll(scrollNotification.metrics.pixels);

           }
         },

          child:  ListView(
            
          children: <Widget>[
            Container(
            height: 200,
            
            child: Swiper(
                onTap: (index){
                  print(index);
                },
                itemCount: _images.length, //图片总数
                 autoplay: true, //是否自动播放
                itemBuilder: (BuildContext content,int index){
                return Image.network(_images[index],fit: BoxFit.fill,);
                },
                pagination: SwiperPagination(), //指示器

              ),
             ),
             
             //funcation
            Padding(
              padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
              child:LocalNavWidget(localNavList: localNavList),

             ),

             Container(
               height: 800,
               child: ListTile(
                 title: Text(resultString),
               ),

             )
          ],
        ),
        ),
          ),
          Opacity(
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
          ) 

        ],
      ),
    );
  }
}