import 'package:flutter/material.dart';
import 'package:flutter_trip/model/home_model.dart';


class SubNavWidget extends StatelessWidget {

  final List<CommonModel> subNavList;

  const SubNavWidget({Key key,@required this.subNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      // height: 88,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: EdgeInsets.all(7),
        child:_items(context) ,
      ),
    );
  }
  _items(BuildContext context){

    if(subNavList == null) return null;
    List<Widget> items = [];
    subNavList.forEach((model){
        items.add(_item(context, model));

    });

//计算出第一行显示的数量
int separete  = (subNavList.length /2 + 0.5).toInt();
return Column( 
    children: <Widget>[
      
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items.sublist(0,separete),
      ),
      Padding(
        padding: EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(separete,subNavList.length),

        ),
      )
    ],
);
// return Row(
//   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   children:items,
// );

  }

 Widget _item(BuildContext context,CommonModel model){
    return Expanded(  //加这个可以让每个item居中显示
    // flex: 1, 试了效果加不加这句看不出来什么
child:  GestureDetector(
      onTap: (){

      },
      child: Column(
        children: <Widget>[
          Image.network(
            model.icon,
            height: 18,
            width: 18,
          ),
          Text(model.title,
          style:TextStyle(
            fontSize: 12
          ),
          ),
        ],
      ),
    ),

  
    );

  }
}