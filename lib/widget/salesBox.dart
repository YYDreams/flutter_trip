
import 'package:flutter/material.dart';
import 'package:flutter_trip/model/home_model.dart';

//底部卡片入口
class SaledBoxWidget extends StatelessWidget {

  final SalesBox salesBoxModel;
  const SaledBoxWidget({Key key,@required this.salesBoxModel, List<CommonModel> subNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        
      ),
      child: _items(context),

    );

  }

_items(BuildContext context){

  if(salesBoxModel == null) return null;
  List<Widget> items = [];
  items.add(_doubleItem(context, salesBoxModel.bigCard1, salesBoxModel.bigCard2, true, false));
  items.add(_doubleItem(context, salesBoxModel.smallCard1, salesBoxModel.smallCard2, false, false));
  items.add(_doubleItem(context, salesBoxModel.smallCard3, salesBoxModel.smallCard4, false, false));



   return Column(
     children: <Widget>[
       Container(
         height: 44,
         margin: EdgeInsets.only(left: 10),
         decoration: BoxDecoration(
           border: Border(
           bottom: BorderSide(width: 1,color:Color(0xfff2f2f2))),

         ),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
            Image.network(salesBoxModel.icon,
            height: 15,fit:  BoxFit.fill),
           Container(
             padding: EdgeInsets.fromLTRB(10, 1, 8, 1),
             margin: EdgeInsets.only(right: 8),
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(20),
               gradient: LinearGradient(colors: 
               [Color(0xffff4e63),Color(0xffff6cc9)],
               begin: Alignment.centerLeft,
               end: Alignment.centerRight,
               ),
             ),
             child: GestureDetector(
               onTap: (){

               },
               child: Text('获取更多福利> ',
               style: TextStyle(
                 fontSize: 12,
                 color: Colors.white,

               ),),
             ),

           )             
           ],
         ),
       ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items.sublist(0,1),


      ),
         Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items.sublist(1,2),
        

      ),
         Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items.sublist(2,3),
        

      ),


     ],
   );



}
 
  Widget _doubleItem(BuildContext context,CommonModel leftCardModel,CommonModel rightCardModel,bool isBig,bool last){

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[_item(context, leftCardModel,isBig, true, last),
        _item(context, rightCardModel,isBig, false, last),
        ],
        
    );


  }

  Widget _item(BuildContext context,CommonModel model,bool isBig,bool isLeft, bool isLast){

   BorderSide borderSide = BorderSide(width: 0.8,color: Color(0xfff2f2f2));
    return GestureDetector(
       onTap: (){

       },
       child: Container(
         decoration: BoxDecoration(
           border: Border(
             right: isLeft ? borderSide : BorderSide.none,
             bottom: isLast? BorderSide.none: borderSide
           )
         ),
         child: Image.network(
           model.icon,
           fit:BoxFit.fill,

            //获取屏幕的宽度
            width: MediaQuery.of(context).size.width / 2 - 8,
            height: isBig ? 129 : 80,
         ),

       ),
    );
  }

}
