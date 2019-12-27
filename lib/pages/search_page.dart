
import 'dart:ui';

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

       body:  Container(
         padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
         child:  Column(
         children: <Widget>[
           _setupSearchBar,
          
          //removePadding去掉多余的间歇问题
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
           child:  Expanded(
              flex: 1,  //自适用高度
              child: ListView.builder(
                // 在创建ListView视图时,漏写itemCount 会报RangeError (index): Invalid value: Not in range 0..16, inclusive: 19
              itemCount: searchModel?.data?.length ?? 0,
              itemBuilder: (BuildContext context, int index){
               return _item(index);
             },
           ),
            ),
          )
           
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
         //设置UI(左边:图片  右边:上下两行文字显示)
         child: Row(
           children: <Widget>[
             //左边的图片
             _setupLeftImage(item),
            //右边的文字
            _setupRightTitle(item),
          
           ],
         )

    ),
);


}
Widget   _setupLeftImage(SearchItem item){

  return   Container(
                margin: EdgeInsets.all(1),
                child: Image(
                  color:Colors.red,
                  height: 25,
                  width: 25,
                  image: AssetImage(_typeImage(item.type)),
                ),      
             );
}

Widget _setupRightTitle(SearchItem item){
  return    Column(
               children: <Widget>[
                 //正标题
                 Container( 
                   width: MediaQuery.of(context).size.width - 2 * 25,
                   child: _title(item),
                 ),
                 //副标题
                 Container(
                   margin: EdgeInsets.only(top: 10),
                   width: MediaQuery.of(context).size.width - 2 * 25,
                   child: _subTitle(item),
                 )
               ]
             );
}
 
//搜索结果图片
String _typeImage(String type){

 String path =  'travelgroup';
  if (type == null){
      return 'assets/images/type_travelgroup.png';
  }
  for (final item in kTypes ) {

  if (type.contains(item)) {
    path  = item;
    break;
  } 
}
 return 'assets/images/type_$path.png';



}


//搜索结果标题
Widget _title(SearchItem item){

  if(item == null) return null;

 //TextSpan显示附文本的辅助类
  List<TextSpan> spans = [];
  spans.addAll(_keywordTextSpans(item.word, searchModel.keyword));
  spans.add(
    TextSpan(
      text: '' + (item.districtname ?? '') + ' ' + (item.zonename ?? ''),
      style: TextStyle(fontSize: 12,color: Colors.grey),
    )
  );
  

return RichText(text: TextSpan(children: spans));

}
//搜索结果副标题
Widget _subTitle(SearchItem item){

if(item == null) return null;
return RichText(
text: TextSpan(children: <TextSpan>[
TextSpan(
      text: item.price ?? '',
      style: TextStyle(fontSize: 16,color: Colors.orange),
      
    ),
    TextSpan(
      text: ' ' + (item.type ?? ''),
      style: TextStyle(fontSize: 12,color: Colors.grey)
      ),
    ]),
  );
}
//实现富文本显示
_keywordTextSpans(String word,String keyword){

List<TextSpan> spans = [];
if (word == null || word.length == 0) {
  return spans;
}

  //搜索关键字高亮忽略大小写
  String wordL = word.toLowerCase(), keywordL = keyword.toLowerCase();

List<String> arr = wordL.split(keywordL);
TextStyle normalStyle = TextStyle(fontSize: 16,color: Colors.black87);
TextStyle keywordStyle = TextStyle(fontSize: 16,color: Colors.orange);

int preIndex = 0;

for (int i = 0; i < arr.length; i++) {
  if (i != 0) {
    preIndex = word.indexOf(keywordL,preIndex);
    spans.add(TextSpan(
      text: word.substring(preIndex, preIndex + keyword.length),
      style: keywordStyle
    ));

  }
  String val = arr[i];
  if (val != null && val.length >0) {
    
    spans.add(TextSpan(text:val,style:normalStyle));
  }

}




return spans;


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

