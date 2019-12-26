import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/model/search_model.dart';

//定义所有的url地址
//首页接口
const home_url ='https://www.devio.org/io/flutter_app/json/home_page.json';

//搜索接口 
const search_url ='https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=';


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


}