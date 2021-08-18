import 'dart:convert';

import 'package:delivey/src/api/enviroment.dart';
import 'package:delivey/src/models/response_api.dart';
import 'package:delivey/src/utils/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:delivey/src/models/user.dart';
import 'package:delivey/src/models/categories.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
class CategoriesProvider{
  String _url = Enviroment.API_Delibery;
  String _api ='api/categories';

  BuildContext context;
  Users sessionuser;

  Future init(BuildContext context, Users sessionuser){
    this.context = context;
    this.sessionuser = sessionuser;

  }

  Future<ResponseApi> create(Category category ) async{

    try{

      Uri url = Uri.http(_url, '$_api/create');
      String BodyParams = json.encode(category);
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
}