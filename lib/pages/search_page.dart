
import 'package:flutter/material.dart';
import 'package:flutter_trip/model/search_model.dart';
import 'package:flutter_trip/network/network.dart';
import 'package:flutter_trip/widget/searchNavBar.dart';
import 'package:flutter_trip/widget/webView.dart';

const kDefaultText = '';
const kDefalutTip = '请输入';


const kTypes = [
  'channelgroup',
  'gs',
  'plane',
  'train',
  'cruise',
  'district',
  'food',
  'hotel',
  'huodong',
  'shop',
  'sight',
  'ticket',
  'travelgroup'
];
class SearchPage extends StatefulWidget {
  final bool hideLeft;

  final String keyword;
  final String searchUrl;
  final String defalutTip;
  SearchPage({Key key,
  this.hideLeft = false,
  this.keyword ,
  this.searchUrl,
  this.defalutTip
  }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();

}

class _SearchPageState extends State<SearchPage> {
  SearchModel searchModel;
  String keyword;



  void initState() {
    if (widget.keyword != null) {
      _onTextChangeAction(widget.keyword);
    }
    super.initState();
  }
  @override

 
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('搜索'),
      // ),
    //  Container
       
     
       body:  Container(
         padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
         child:  Column(
         children: <Widget>[
           _setupSearchBar,
          
          // MediaQuery.removePadding(
            // removeTop: true,
            // context: context,
             Expanded(
              flex: 1,  //自适用高度
              child: ListView.builder(
                // 在创建ListView视图时,漏写itemCount 会报RangeError (index): Invalid value: Not in range 0..16, inclusive: 19
              itemCount: searchModel?.data?.length ?? 0,
              itemBuilder: (BuildContext context, int index){
               return _item(index);
             },
           ),
            ),
          // )
           
         ],
       ),
       ),
    );
  }








 Widget get _setupSearchBar{
  return Column(
      
         children: <Widget>[
         Container(
           child: Container(
            //  padding: EdgeInsets.only(top: 0),
            //  height: 80,
            child: SearchNavBarWidget(
           hideLeft: true,
           defalutTip: widget.defalutTip,
           defaultText: kDefaultText,
           speakClick: _jumpToSpeakAction,
           leftButtonOnClick: _jumpLeftButtonAction,
           inputBoxClick: _jumpToSearchAction,
           rightButtonOnClick: _jumpToMessageAction,
           onChanged: _onTextChangeAction,
           )
            ),
         )
         ],
       );

  }



// Widget
Widget _item(index){


if (searchModel == null || searchModel.data == null) {return null;}
SearchItem item  = searchModel.data[index];

print(item.word);

return GestureDetector(

   onTap: (){ //跳转 点击itemd都要进行跳转
   Navigator.push(context, MaterialPageRoute(
     builder:(context)=> WebView(url: item.url,title: '详情',),
    ));
   },
      
    child: Container(
         padding: EdgeInsets.all(10),
         decoration: BoxDecoration(
           border: Border(bottom: BorderSide(width: 0.3,color: Colors.grey)),
         ),

         child: Row(
           //左边图片  右边 上下两行显示

           children: <Widget>[
             Column(
               children: <Widget>[
                 Container( 
                   width: 300,
                   child: Text('${item.word??''} ${item.districtname??''}'),
                 ),
                 Container(
                   width: 300,
                   child: Text('${item.price??''} ${item.zonename??''}'
                 ),
                 )
               ]
             ),
           ],
         )


    ),
);


}

//搜索结果图片
String _typeImage(String type){

  if (type == null) 
  return 'assets/images/type_travelgroup.png';


}
//搜索结果标题
Widget _title(SearchItem item){



}
//搜索结果副标题
Widget _subTitle(SearchItem itme){

}
  //SEL Actions
  //输入框内容发生改变就会调用
_onTextChangeAction(text) async {

 keyword  = text;
if (text.length == 0) {
  setState(() {
    searchModel = null;
      
  });
   return;
}
   try{
      SearchModel model = await NetworkRequest.searchDataFromNetwork(keyword);
      
      print('===================');
      print(model.keyword);
      if (model.keyword == keyword) {
      setState(() {
      searchModel = model;
      });
      }
    }catch(error){
      print(error);
    }
 } 

_jumpLeftButtonAction(){

   Navigator.pop(context);


}
_jumpToSearchAction(){
  print('跳转搜索页面');

}
_jumpToSpeakAction(){
   print('跳转语音');

}

_jumpToMessageAction(){
  print('跳转消息页面');
}

 
}

