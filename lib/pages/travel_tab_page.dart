import 'package:flutter/material.dart';
import 'package:flutter_trip/model/travel_model.dart';
import 'package:flutter_trip/network/network.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_trip/widget/cacehed_image.dart';


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
    super.initState();
    
  }
    void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       child: new StaggeredGridView.countBuilder(
         crossAxisCount: 2, // 总共显示几列

  //?.  表示travelItems不为空的情况下 显示travelItems.length  为空则返回0
  itemCount: travelItems?.length ?? 0 , //所有item的数量
  itemBuilder: (BuildContext context, int index) => _TravelItem(
    item: travelItems[index], index: index),
  staggeredTileBuilder: (int index) =>
  new StaggeredTile.fit(1), //
      // new StaggeredTile.count(2, index.isEven ? 2 : 1), //
)
,
    );
  }


  _loadData() async{

    try{

     TravelModel model = await NetworkRequest.travelListDataFromNetwork(widget.travelUrl?? defalut_travel_url, widget.groupChannelCode, pageIndex, pageSize);

      

      setState(() {
        List<ResultList> items =  _filterItems(model.resultList);
        if (travelItems !=  null) {
          travelItems.addAll(items);
        }else{
          travelItems = items;
        }
      });


    }catch(error){

      print( error);
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

  //下拉刷新
  Future<Null> _handlerRefresh() async{
    _loadData();
    return null;

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
          color: Colors.transparent,
          clipBehavior:  Clip.antiAlias,
          borderRadius: BorderRadius.circular(6),
          child: Column(
            children: <Widget>[
              _itemImage,
            ],

          ),
          
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




