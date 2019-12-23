import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_trip/model/home_model.dart';

//定义所有的url地址
//首页接口
const home_url ='https://www.devio.org/io/flutter_app/json/home_page.json';

//搜索接口

class NetworkRequest{

//首页数据
  static Future<HomeModel> homeDataFromNetwork() async{
    Response response =  await Dio().get(home_url);

    if(response.statusCode == 200){
      
      return HomeModel.fromJson(response.data);
    }else{
      throw Exception('Failed to load home_page.json');


    }

  }





}