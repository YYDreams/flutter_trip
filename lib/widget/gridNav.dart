
import 'package:flutter/material.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/widget/webView.dart';


//酒店 机票 旅游 三部分
class GirdNavWidget extends StatelessWidget {
  final GridNav gridNavModel;
  const GirdNavWidget({Key key,@required this.gridNavModel}) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    //设置圆角
    return PhysicalModel(
      color: Colors.transparent,//设置成透明的
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,//是否裁剪
      child: Column( //
      children: _girdItems(context),
      ),

    );

  }


//
   _girdItems(BuildContext context){

       List<Widget> items = [];
       if (gridNavModel == null) return items;

        //酒店
       if(gridNavModel.hotel != null){
       
       items.add(_gridItem(context,gridNavModel.hotel,true));
       }
       //机票
       if(gridNavModel.flight != null){
         items.add(_gridItem(context,gridNavModel.flight,false));
       }
       //旅游
       if(gridNavModel.travel != null){
         items.add(_gridItem(context,gridNavModel.travel,false));
       }

     return items;
    }


      
      //first标识的用意是 因为要与上面有个间隙
     _gridItem(BuildContext context,GridNavItem gridNavItem,bool first){
       List<Widget> items = [];
         items.add(_mainItem(context, gridNavItem.mainItem));
         items.add(_doubleItem(context,gridNavItem.item1,gridNavItem.item2));
         items.add(_doubleItem(context,gridNavItem.item3,gridNavItem.item4));
      List<Widget> exandItems = [];
      items.forEach((item){
        exandItems.add(Expanded(child: item,flex: 1,));
      });
      Color statrtColor = Color(int.parse('0xff'+ gridNavItem.startColor));
      Color endColor = Color(int.parse('0xff'+ gridNavItem.endColor));
      return Container( 
            height: 88,
            margin: first? null:EdgeInsets.only(top: 3),
            decoration:BoxDecoration(
               //线性渐变
               gradient: LinearGradient(colors: [statrtColor,endColor]),
            ),
            child: Row(children: exandItems),

      );


    }
     //左边一个item
    _mainItem(BuildContext context,CommonModel model){
      
           return  _itemsGesture(context, 
        Stack(
          alignment: Alignment.topCenter, //设置文字顶部中心
          children: <Widget>[
            
            Image.network(model.icon,fit: BoxFit.contain,
            width: 88,height: 121,
            alignment: AlignmentDirectional.bottomEnd, //
            ),
          Container(
            margin: EdgeInsets.only(top: 10), //使用Container包裹一层 设置文字距离顶部的距离
            child:  Text(model.title,
              
               style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              

            ),
            ),
          )

          ],

        ), model);
      
      // return GestureDetector(
      //   onTap: (){
      //     Navigator.push(context, MaterialPageRoute(builder: (context) =>
      //     WebView(url: model.url,statusColor: model.statusBarColor,title: model.title,hideAppBar: model.hideAppBar)));
      //   },
      //   //绝对定位
      //   child: Stack(
      //     children: <Widget>[
      //       Image.network(model.icon,fit: BoxFit.contain,
      //       width: 88,height: 121,
      //       alignment: AlignmentDirectional.bottomEnd, //
      //       ),
      //       Text(model.title,style: TextStyle(
      //         fontSize: 12
      //       ),
      //       ),

      //     ],

      //   ),
      // );
      
    }
      
  //右边2个Item
_doubleItem(BuildContext context,CommonModel topItem,CommonModel bottomItem){

  return Column(
    children: <Widget>[
      Expanded( //垂直方式展开
      child: _item(context, topItem, true),
      ),
       Expanded( //撑开
      child: _item(context, bottomItem, false),
      ),
    ],
  );

}
   _item(BuildContext context,CommonModel model, bool firstItem){
     BorderSide borderSide = BorderSide(width: 0.8,color: Colors.white);
     //水平方向展开
     return FractionallySizedBox(
       widthFactor: 1,
       child: Container(
         decoration: BoxDecoration(
           border: Border(
             left: borderSide,
             bottom: firstItem?borderSide:BorderSide.none,
           )
         ),
         child: _itemsGesture(context, Center(
           child: Text(model.title,
           textAlign: TextAlign.center,
           style: TextStyle(
             fontSize: 14,
             color: Colors.white,
           ),
           ),
         ),
 model),
       ),

     );

   }


//all items的点击事件
_itemsGesture(BuildContext context,Widget widget,CommonModel model){

return GestureDetector(
onTap: (){

 Navigator.push(context, MaterialPageRoute(builder: (context) =>
 WebView(url: model.url,statusColor: model.statusBarColor,title: model.title,hideAppBar: model.hideAppBar)));

},
child:  widget,
);

}

}