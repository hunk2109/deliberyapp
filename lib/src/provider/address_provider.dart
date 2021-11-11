
import 'dart:convert';

import 'package:delivery/src/api/enviroment.dart';
import 'package:delivery/src/models/address.dart';
import 'package:delivery/src/models/response_api.dart';
import 'package:delivery/src/models/user.dart';
import 'package:delivery/src/utils/shared_pref.dart';
import 'package:flutter/cupertino.dart';


import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
class AddressProvider{
  String _url = Enviroment.API_Delibery;
  String _api ='api/address';

  BuildContext context;
  Users sessionuser;

  Future init(BuildContext context, Users sessionuser){
    this.context = context;
    this.sessionuser = sessionuser;

  }

  Future<List<Address>> getall(String idUser) async {
    try{
      Uri url = Uri.http(_url, '$_api/findByUser/${idUser}');
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
      Address address = Address.fromJsonList(data);
      return address.toList;


    }
    catch(e){
      print('Error: $e');
      return [];
    }
  }
  Future<ResponseApi> create(Address address ) async{

    try{

      Uri url = Uri.http(_url, '$_api/create');
      String BodyParams = json.encode(address);
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