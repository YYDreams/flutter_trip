import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

const catch_urls = ['m.ctrip.com/', 'm.ctrip.com/html5/', 'm.ctrip.com/html5'];


//浏览器组件 
class WebView extends StatefulWidget {
  //定义常量
  final String url;
  final String statusColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;  


  WebView({this.url,this.statusColor  ,this.title,this.hideAppBar,this.backForbid = false});

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {

final webviewPlugin = new FlutterWebviewPlugin();

//保存变量
 StreamSubscription<String> _onUrlChanged;
 StreamSubscription<WebViewStateChanged> _onStateChanged;
 StreamSubscription<WebViewHttpError> _onHttpError;
  bool exiting = false;


@override
void initState() { 
  super.initState();
  //防止页面重新打开
  webviewPlugin.close();

  //注册监听
 _onUrlChanged = webviewPlugin.onUrlChanged.listen((String url){

 });
 //
_onStateChanged = webviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
switch(state.type){
  case WebViewState.startLoad:

  if(_isToMain(state.url) && !exiting){
    if(widget.backForbid){

      webviewPlugin.launch(widget.url);

    }else{

      Navigator.pop(context);
      exiting = true;

    }
  }

  break;

  case WebViewState.finishLoad:
  break;
  default:
  break;
  }
});

_onHttpError = webviewPlugin.onHttpError.listen((WebViewHttpError error){
  print(error);

});


  
  
  
}
  @override
  Widget build(BuildContext context) {
    String statusBarColrStr = widget.statusColor ?? 'ffffff';
    Color backButtonColor;
    if (statusBarColrStr == 'ffffff'){
      backButtonColor = Colors.black;
    }else{
      backButtonColor = Colors.white;

    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(Color(int.parse('0xff'+ statusBarColrStr)),backButtonColor),
          Expanded(child:WebviewScaffold(url:widget.url,
          withZoom: true, //是否缩放
          withLocalStorage: true,//是否使用本地存储
          hidden: true , //默认隐藏
          //Waiting
          initialChild: Container(
            color: Colors.white,
            child: Center(
              child: Text('Waiting...加载中'),
            ),

          ),
           
          
          ) ),

        ],
           
      ),

    );
   

  }


   bool _isToMain(String url){
     bool contain = false; 
     for (final value in  catch_urls){
       if(url?.endsWith(value) ?? false){
         contain = true;
         break;
       }
    }
    return contain;
   }

   _appBar(Color backgroundColor, Color backButtonColor){

     if (widget.hideAppBar ?? false){
       return Container(
         color: backgroundColor,
         height: 30,

       );
     }
     //非隐藏状态下  app
     return Container(
       
       //返回按钮看不到了 iphonex 处理
       color: backButtonColor,
       padding: EdgeInsets.fromLTRB(0, 40 , 0, 10),

       // appBar撑满整个屏幕的高度 (FractionallySizedBox)
       //
       child:  FractionallySizedBox(
         
         widthFactor: 1, //宽度撑满
         child: Stack(
           children: <Widget>[
             GestureDetector(
               onTap: (){
                 //返回上一页
                 Navigator.pop(context);
               },
               child: Container(
                 margin:  EdgeInsets.only(left: 10),
                 child: Icon(
                   Icons.close,
                   color:Colors.red, //backButtonColor
                   size: 26,

                 ),
               ),
             ),
            //绝对定位
              Positioned(
              left: 0,
              right: 0,
              child: Center(
                child: Text(widget.title??'',
                style:TextStyle(
                  color: backButtonColor,
                  fontSize: 20,


                ),
                ),
            
              ),
            ),
           ],
         ),
       ),
     );


   }

 //在该方法里面取消监听
 @override
 void dispose() { 
   _onUrlChanged.cancel();
   _onStateChanged.cancel();
   _onHttpError.cancel();
   webviewPlugin.dispose();

   super.dispose();

 }

}