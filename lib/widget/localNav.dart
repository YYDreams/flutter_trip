import 'package:flutter/material.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/widget/webView.dart';


//组件
class LocalNavWidget extends StatelessWidget {


final List<LocalNavList> localNavList ; 
// final String name ; 

  //构造方法  required表示必传参数  如果不加的话 则表示可选
const LocalNavWidget({Key key, @required this.localNavList}) : super(key: key);

  // eg:设置默认值
    // const LocalNavWidget({Key key, @required this.localNavList,this.name = '哈哈哈'}) : super(key: key);



  @override
  Widget build(BuildContext context) {

      return Container(
        height: 64,
        //装饰器
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          )

        ),
        child: Padding(
          padding: EdgeInsets.all(7),
          child: _items(context),

        ),

      );

  }

_items(BuildContext context){
   if (localNavList == null) return null;
   List<Widget> items = [];
   
   localNavList.forEach((model){
   items.add(_item(context,model));

   });
      //排列方式 很重要
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items,
      );
}

//Widget:返回类型
Widget _item(BuildContext context,LocalNavList model){
 
 return GestureDetector( //点击响应时间

   //点击push到下一个页面
   onTap: (){
     Navigator.push(context, 
     MaterialPageRoute(builder: (context) =>
     WebView(url: model.url,statusColor: model.statusBarColor,hideAppBar: model.hideAppBar),

     ));


   },
   child: Column(
     children: <Widget>[
       Image.network(
         model.icon,
         height: 32,
         width: 32,
       ),
       Text(
         model.title,
         style: TextStyle(
           fontSize: 12,

         ),
       ),
     ],
   ),

 );
}
}