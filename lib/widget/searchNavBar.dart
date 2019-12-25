import 'dart:ffi';

import 'package:flutter/material.dart';

//定义枚举
enum SearchBarType{home,normal,homeLight}

class SearchNavBarWidget extends StatefulWidget {

  final bool enabled; //是否禁止搜索
  final bool hideLeft; //左边按钮是否隐藏
  final SearchBarType searchBarType;
  final String defalutTip; //默认的提示文案
  final String defaultText;
  //回调
  final void Function() leftButtonOnClick; //左边按钮点击回调
  final void Function() rightButtonOnClick; //右边按钮点击回调
  final void Function() speakClick;
  final void Function() inputBoxClick; ////输入框点击回调
  final ValueChanged<String> onChanged; // 内容变化回调
  
  SearchNavBarWidget({Key key,
  this.enabled = true,
  this.hideLeft,
  this.searchBarType = SearchBarType.normal,
  this.defalutTip,
  this.defaultText,
  this.leftButtonOnClick,
  this.rightButtonOnClick,
  this.speakClick,
  this.inputBoxClick,
  this.onChanged}) : super(key: key);

  @override
  _SearchNavBarWidgetState createState() => _SearchNavBarWidgetState();
}

class _SearchNavBarWidgetState extends State<SearchNavBarWidget> {
  bool showClear = false;
  final TextEditingController _controller = TextEditingController();

  @override
  //初始化
  void initState() { 

    if(widget.defaultText != null){
      setState(() {
        _controller.text = widget.defaultText;

      });
    }
    super.initState();
    
  }
  @override

  Widget build(BuildContext context) {
   
   return widget.searchBarType == SearchBarType.normal ?_normalSearchBar():_homeSearcBar();
  }



    _normalSearchBar(){

      return Container(
        padding: EdgeInsets.only(top: 10),
        child: Row(
          children: <Widget>[
            //左边返回按钮
            _tapOnClick(Container(
              padding: EdgeInsets.only(left: 10),
              child: widget.hideLeft?? false? null: Icon(Icons.arrow_back_ios,color: Colors.grey,size: 26),
            ),
             widget.leftButtonOnClick),
             //中间输入框
             Expanded(

               flex: 1,
               child: _inputBox(),

             ), 
             //右边搜索按钮
             _tapOnClick(Container(
               padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
               child:Text(
                 '搜索', style:TextStyle(
                   color: Colors.blue,
                   fontSize: 15,
                   
                 ),
               ),

             ), 
             widget.rightButtonOnClick),

             



          ],
            



        ),

      );  


      }

      //输入框
      _inputBox(){

        //设置输入框的背景颜色
       Color inputBoxColor;
       if(widget.searchBarType == SearchBarType.home){
         inputBoxColor  = Colors.white;
       }else{
         inputBoxColor = Color(int.parse('0xffEDEDED'));
       }


      return Container(
        height: 40,
        decoration: BoxDecoration(
          color: inputBoxColor,
          borderRadius: BorderRadius.circular(
            widget.searchBarType == SearchBarType.normal ? 5 : 15,
          ),
        ),
        // decoration: BoxDecoration(

        //   color: inputBoxColor,

        // ),
         child: Row(
           children: <Widget>[
             Icon(Icons.search,

             size: 20,
             color: widget.searchBarType == SearchBarType.normal ? Color(0xffA9A9A9): Colors.blue,
             ),
             //
             Expanded(
               
               flex: 1,
               child: widget.searchBarType  == SearchBarType.normal 
               ?TextField(
                 
                 controller: _controller,
                 onChanged: _onChanged,
                 autofocus: true,
                 style: TextStyle(
                  //  fontSize: 14,
                   fontWeight: FontWeight.w300,
                   color: Colors.black,
                 ),

                //输入文本样式
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  
                  border: InputBorder.none,
                  hintText: widget.defalutTip ??'',
                  // hintStyle: TextStyle(
                  //   fontSize: 18
                  // )

                ),


               ): _tapOnClick(
                 Container(
                   child: Text(
                     widget.defaultText,
                      style: TextStyle(
                   fontSize: 13,
                   color: Colors.grey,
                 ),),
                  

               ), 
               widget.inputBoxClick)
             ),
             !showClear 
             ? _tapOnClick(Icon(
               Icons.mic,
               size: 22,
               color: widget.searchBarType == SearchBarType.normal ? Colors.blue: Colors.grey,

              
             ), widget.speakClick)
             : _tapOnClick(Icon(
               Icons.clear,size:22,
               color:Colors.grey,
               ), (){
                 setState(() {
                   _controller.clear();
                 });
                 _onChanged('');

               })
           ],
         ),
      );


      }

    _homeSearcBar(){

      }
      //包裹点击事件
      _tapOnClick(Widget child, void Function() callback){
        return GestureDetector(
          onTap: (){
            if(callback != null) callback();
          },
          child: child,
        );
      }


  void _onChanged(String text){
    if(text.length > 0){
      setState(() {
        showClear = true;
      }); 
    }else{
      setState(() {
        showClear = false;
      });
    }

    if(widget.onChanged != null){
      widget.onChanged(text);
    }

  }
}