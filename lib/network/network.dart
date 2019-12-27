import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/model/search_model.dart';
import 'package:flutter_trip/model/travel_model.dart';
import 'package:flutter_trip/model/travel_tab_model.dart';

//定义所有的url地址
//首页接口
const home_url ='https://www.devio.org/io/flutter_app/json/home_page.json';

//搜索接口 
const search_url ='https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=';

//旅拍类别接口
const travel_tab_url =
    'https://apk-1256738511.file.myqcloud.com/FlutterTrip/data/travel_page.json';



//根据旅拍类别获取列表接口
const travelList_url =
    'https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031010211161114530&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5';


//旅拍类别的固定参数
var params = {
  "districtId": -1,
  "groupChannelCode": "tourphoto_global1",
  "type": null,
  "lat": 34.2317081,
  "lon": 108.928918,
  "locatedDistrictId": 7,
  "pagePara": {
    "pageIndex": 1,
    "pageSize": 10,
    "sortType": 9,
    "sortDirection": 0
  },
  "imageCutType": 1,
  "head": {
    "cid": "09031010211161114530",
    "ctok": "",
    "cver": "1.0",
    "lang": "01",
    "sid": "8888",
    "syscode": "09",
    "auth": null,
    "extension": [
      {"name": "protocal", "value": "https"}
    ]
  },
  "contentType": "json"
};

//网络请求类
class NetworkRequest{

//首页数据请求
  static Future<HomeModel> homeDataFromNetwork() async{
    Response response =  await Dio().get(home_url);

    if(response.statusCode == 200){
      
      return HomeModel.fromJson(response.data);
    }else{
      throw Exception('Failed to load home_page.json');

    }
  }

  //搜索数据请求
  static Future<SearchModel> searchDataFromNetwork(String keyword) async{

      Response response = await Dio().get(search_url + keyword);
      print(search_url + keyword);
      if (response.statusCode == 200) {
        
        SearchModel model = SearchModel.fromJson(response.data);
        //这里的用意是：只有当当前输入的内容和服务端返回的内容一致市才渲染
        model.keyword  = keyword;
       return model;
      }else{
        throw Exception('Failed to load search');
      }
      
  }

    //旅拍类别数据请求
    static Future<TravelTabModel>  travelTabDataFromNetwork() async{

        Response response = await Dio().get(travel_tab_url);

        if (response.statusCode == 200) {
          return TravelTabModel.fromJson(response.data);

        }else{
          throw Exception('Failede to load travel');
        }
    }
    //根据类别获取旅拍列表数据请求
    static Future<TravelModel> travelListDataFromNetwork(String url,String groupChannelCode,int pageIndex, int pageSize) async{


        Map paramsMap =  params['pagePara'];
        paramsMap['pageIndex'] = pageIndex;
        paramsMap['pageSize'] = pageSize;
        params['groupChannelCode'] = groupChannelCode;
      Response response = await Dio().post(url,data: params);
      if (response.statusCode == 200) {
        
        return TravelModel.fromJson(response.data);

      }else{
          throw Exception('Failede to load travelList');
        }





      
       
 

    }


}