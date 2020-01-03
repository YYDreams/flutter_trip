import 'package:flutter/material.dart';
import 'package:flutter_trip/model/travel_model.dart';
import 'package:flutter_trip/network/network.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_trip/widget/cacehed_image.dart';
import 'package:flutter_trip/widget/loading_container.dart';


const defalut_travel_url = 'https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031014111431397988&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5';


class TravelTabPage extends StatefulWidget {
  final String travelUrl; 
  final Map params;
  final String groupChannelCode;
  final int type;
  
  const TravelTabPage({Key key, 
      this.travelUrl,
      this.params, 
      this.groupChannelCode, 
      this.type})
      : super(key: key);

  @override
  _TravelTabPageState createState() => _TravelTabPageState();

}


class _TravelTabPageState extends State<TravelTabPage> {

  List<ResultList> travelItems;
  int pageIndex =  1;
  int pageSize =  10;
  bool _loading = true;
  ScrollController _scrollController = ScrollController();

  @override

  void initState() { 

    _loadData();
    _scrollController.addListener((){
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _loadData(loadMore: true);

      }

    });
    super.initState();
    
  }
    void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

return Scaffold(
     body: LoadingContainer(
       isLoading: _loading,
       child: RefreshIndicator(
         onRefresh: _handleRefresh,
         child: MediaQuery.removePadding(
           removeTop: true,
           context: context,
           child: StaggeredGridView.countBuilder(
             controller: _scrollController,
             crossAxisCount: 2,// 总共显示几列
             //?.  表示travelItems不为空的情况下 显示travelItems.length  为空则返回0
              itemCount: travelItems?.length ?? 0 , //所有item的数量
             itemBuilder: (BuildContext context,int index)=> _TravelItem(
               item: travelItems[index],index: index),
               staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
           ),
         ),
       ),
     ),
    

);

  }
Future<Null> _handleRefresh() async{
  _loadData();
  return null;

}

  _loadData({loadMore = false}) async{


    if (loadMore) {
      pageIndex++;
    }else{
      pageIndex = 1;

    }

    try{

     TravelModel model = await NetworkRequest.travelListDataFromNetwork(widget.travelUrl?? defalut_travel_url, widget.groupChannelCode, pageIndex, pageSize);

      

      setState(() {
        List<ResultList> items =  _filterItems(model.resultList);
        if (travelItems !=  null) {
          travelItems.addAll(items);
        }else{
          travelItems = items;
        }
        _loading = false;
      });


    }catch(error){

      print( error);
      _loading = false;

    }



  }



  //数据过滤
  List<ResultList> _filterItems(List<ResultList> resultList){
    if (resultList == null) {
      return null;
    }
    List<ResultList>  filterItems = [];
    resultList.forEach((item){
      if (item.article != null) {
        filterItems.add(item);
      }
    });
    return filterItems;

  }
  
}

class _TravelItem extends StatelessWidget {

  final ResultList item;
  final int index;

  const _TravelItem({Key key,this.item,this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: (){

      },

      child: Card(
        
        child: PhysicalModel(

          //设置透明度、圆角、是否裁剪   (borderRadius/clipBehavior需结合使用)
          color: Colors.transparent,
          clipBehavior:  Clip.antiAlias,
          borderRadius: BorderRadius.circular(6),
          child: Column(
            children: <Widget>[
              _itemImage,
              _itemTitle,
              _itemInfo,
            ],


          ),
          
        ),
      ),
    );
  }

Widget get _itemInfo{

return Container(
  child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[

      Row(
        children: <Widget>[
         
         PhysicalModel(
           color: Colors.transparent,
           clipBehavior: Clip.antiAlias,
           borderRadius: BorderRadius.circular(12),
           child: CachedImage(
             imageUrl: item.article.author?.coverImage?.dynamicUrl,
             width: 24,
             height: 24,
           ),
         ),
         Container(
           padding: EdgeInsets.all(5),
           width: 90,
           color: Colors.red,
           child: Text(
             item.article.author?.nickName,
             maxLines:1,
             overflow: TextOverflow.ellipsis,
             style: TextStyle(fontSize: 12),
             
           ),
         ),



        ],
      ),

      Row(
        children: <Widget>[
          
          Icon(Icons.thumb_up,
          color: Colors.grey,
          size: 14,),
         
         Container(
           padding: EdgeInsets.only(left:4),
           child: Text(
             item.article.likeCount.toString(),
             style:TextStyle(fontSize:10),

           ),

         ),
          
        ],
      )
       
     
      
    ],
  ),

);

}
Widget get _itemTitle{

  return Container(
    padding: EdgeInsets.all(4),
     child: Text(
    item.article.articleTitle,
    overflow: TextOverflow.ellipsis,
    maxLines: 2,
    style: TextStyle(
      fontSize: 14,
      color: Colors.black,
      
    ),
     ),

  );

}
 Widget get _itemImage{

   return Stack(
    children: <Widget>[
        CachedImage(
          inSizedBox: true,
          imageUrl: item.article.images[0]?.dynamicUrl,

        ),
        Positioned(
          bottom: 8,
          left: 8,
          child: Container(
            padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(6),

            ),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),

                ),
                LimitedBox(
                  maxWidth: 130,
                  child: Text(
                    _poiName(),
                    maxLines: 1,

                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12,color: Colors.white),
                    
                  ),
                )
              ],
            ),
          ),
        )
    ],


   );

 }
   String _poiName() {
    return item.article.pois == null || item.article.pois.length == 0
        ? '未知'
        : item.article.pois[0]?.poiName ?? '未知';
  }

}




