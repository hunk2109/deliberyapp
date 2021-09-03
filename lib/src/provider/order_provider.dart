import 'dart:convert';

import 'package:delivey/src/api/enviroment.dart';
import 'package:delivey/src/models/address.dart';
import 'package:delivey/src/models/orders.dart';
import 'package:delivey/src/models/response_api.dart';
import 'package:delivey/src/utils/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:delivey/src/models/user.dart';
import 'package:delivey/src/models/categories.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
class OrderProvider{
  String _url = Enviroment.API_Delibery;
  String _api ='api/order';

  BuildContext context;
  Users sessionuser;

  Future init(BuildContext context, Users sessionuser){
    this.context = context;
    this.sessionuser = sessionuser;

  }

  Future<List<Order>> getByStatus(String status) async {
    try{
      Uri url = Uri.http(_url, '$_api/findByStatus/$status');
      Map<String, String> headers ={
        'Content-type':'application/json',
        'Authorization': sessionuser.sessionToken



      };
      final res = await http.get(url,headers:headers);
      if(res.statusCode == 401){
        Fluttertoast.showToast(msg: 'Sesion Expirada');
        new SharedPref().logout(context);
      }
      final data = json.decode(res.body); //categorias
      Order order = Order.fromJsonList(data);
      return order.toList;


    }
    catch(e){
      print('Error: $e');
      return [];
    }
  }
  Future<List<Order>> getByStatusDelibery(String idDelibery,String status) async {
    try{
      Uri url = Uri.http(_url, '$_api/getByStatusDelibery/$idDelibery/$status');
      Map<String, String> headers ={
        'Content-type':'application/json',
        'Authorization': sessionuser.sessionToken



      };
      final res = await http.get(url,headers:headers);
      if(res.statusCode == 401){
        Fluttertoast.showToast(msg: 'Sesion Expirada');
        new SharedPref().logout(context);
      }
      final data = json.decode(res.body); //categorias
      Order order = Order.fromJsonList(data);
      return order.toList;


    }
    catch(e){
      print('Error: $e');
      return [];
    }
  }
  Future<ResponseApi> create(Order order ) async{

    try{

      Uri url = Uri.http(_url, '$_api/create');
      String BodyParams = json.encode(order);
      Map<String, String> headers ={
        'Content-type':'application/json',
        'Authorization': sessionuser.sessionToken



      };
      final res = await http.post(url,headers:headers,body: BodyParams);
      if(res.statusCode == 401){
        Fluttertoast.showToast(msg: 'Sesion Expirada');
        new SharedPref().logout(context);
      }
      final data = json.decode(res.body);
      ResponseApi resapi = ResponseApi.fromJson(data);
      return resapi;
    }
    catch(e){

      print('Error: $e');
      return null;

    }

  }
  Future<ResponseApi> update(Order order ) async{

    try{

      Uri url = Uri.http(_url, '$_api/updatetoReady');
      String BodyParams = json.encode(order);
      Map<String, String> headers ={
        'Content-type':'application/json',
        'Authorization': sessionuser.sessionToken



      };
      final res = await http.put(url,headers:headers,body: BodyParams);
      if(res.statusCode == 401){
        Fluttertoast.showToast(msg: 'Sesion Expirada');
        new SharedPref().logout(context);
      }
      final data = json.decode(res.body);
      ResponseApi resapi = ResponseApi.fromJson(data);
      return resapi;
    }
    catch(e){

      print('Error: $e');
      return null;

    }

  }

  Future<ResponseApi> updatetoDel(Order order ) async{

    try{

      Uri url = Uri.http(_url, '$_api/updatetodel');
      String BodyParams = json.encode(order);
      Map<String, String> headers ={
        'Content-type':'application/json',
        'Authorization': sessionuser.sessionToken



      };
      final res = await http.put(url,headers:headers,body: BodyParams);
      if(res.statusCode == 401){
        Fluttertoast.showToast(msg: 'Sesion Expirada');
        new SharedPref().logout(context);
      }
      final data = json.decode(res.body);
      ResponseApi resapi = ResponseApi.fromJson(data);
      return resapi;
    }
    catch(e){

      print('Error: $e');
      return null;

    }

  }

  Future<ResponseApi> updatetoDelibered(Order order ) async{

    try{

      Uri url = Uri.http(_url, '$_api/updatetodelibery');
      String BodyParams = json.encode(order);
      Map<String, String> headers ={
        'Content-type':'application/json',
        'Authorization': sessionuser.sessionToken



      };
      final res = await http.put(url,headers:headers,body: BodyParams);
      if(res.statusCode == 401){
        Fluttertoast.showToast(msg: 'Sesion Expirada');
        new SharedPref().logout(context);
      }
      final data = json.decode(res.body);
      ResponseApi resapi = ResponseApi.fromJson(data);
      return resapi;
    }
    catch(e){

      print('Error: $e');
      return null;

    }

  }
}