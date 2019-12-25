import 'package:flutter/material.dart';


//进度条组件
class LoadingContainer extends StatelessWidget {
    final Widget child;
    final bool isLoading;//加载状态
    final bool cover;   // 是否覆盖这个布局
    

  const LoadingContainer({Key key,
  @required this.isLoading,
  this.cover = false,
  @required  this.child})
  : super(key: key);


  @override
  Widget build(BuildContext context) {

      //如果不是cover 也不是isLoading 就显示 child 反之显示_loadingView
      //
    return !cover ? !isLoading  ? child : _loadingView :Stack(
        children: <Widget>[
          child,isLoading? _loadingView : null,

        ],
    );
  

  }

  Widget get _loadingView{
    return Center(
    
        child: CircularProgressIndicator(), //圆
    );

  }
}