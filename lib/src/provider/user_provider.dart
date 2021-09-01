import 'package:flutter/material.dart';
import "package:delivey/src/api/enviroment.dart";
import 'package:delivey/src/models/response_api.dart';
import 'package:delivey/src/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path/path.dart';
import 'package:delivey/src/utils/shared_pref.dart';


class UserProvider{

  String _url = Enviroment.API_Delibery;

  String _api = '/api/users';

  BuildContext context;
  String token;
  Users sessionuser;


  Future init(BuildContext context, {Users sessionuser}){
    this.context = context;
    this.sessionuser = sessionuser;

  }

  Future<Users>getByid(String id) async{
    try{
      Uri url = Uri.http(_url, '$_api/getid/$id');
      Map<String, String> headers ={
        'Content-type':'application/json',
         'Authorization': sessionuser.sessionToken

      };


      final res = await http.get(url,headers:headers );

      if(res.statusCode == 401){ // no autorizado
        Fluttertoast.showToast(msg: 'Tu Sesion Expiro');
        new SharedPref().logout(context);

      }

      final  data = json.decode(res.body);
      Users user = Users.fromJson(data);
      return user;
    }
    catch(e){
      print:('Error: $e');
      return null;
    }

  }

  Future<List<Users>>getByDelibery() async{
    try{
      Uri url = Uri.http(_url, '$_api/getdelibery');
      Map<String, String> headers ={
        'Content-type':'application/json',
        'Authorization': sessionuser.sessionToken

      };


      final res = await http.get(url,headers:headers );

      if(res.statusCode == 401){ // no autorizado
        Fluttertoast.showToast(msg: 'Tu Sesion Expiro');
        new SharedPref().logout(context);

      }

      final  data = json.decode(res.body);
      Users user = Users.fromJsonList(data);
      return user.toList;
    }
    catch(e){
      print:('Error: $e');
      return null;
    }

  }

  Future<Stream> update(Users user,File image) async{
    try{
      Uri url = Uri.http(_url, '$_api/update');
      final request =http.MultipartRequest('PUT',url);
      request.headers['Authorization'] = token;

      if(image != null){
        request.files.add(http.MultipartFile(
            'image',
            http.ByteStream(image.openRead().cast()),
            await image.length(),
            filename: basename(image.path)
        ));
      }

      request.fields['user'] = json.encode(user);
      final response = await  request.send(); // enviar peticion

      if(response.statusCode == 401){ // no autorizado
        Fluttertoast.showToast(msg: 'Tu Sesion Expiro');
        new SharedPref().logout(context);

      }

      return response.stream.transform(utf8.decoder);


    }
    catch(e){
      print('Error: $e}');
    }

  }
  Future<Stream> createWithimg(Users user,File image) async{
    try{
      Uri url = Uri.http(_url, '$_api/create');
      final request =http.MultipartRequest('POST',url);

      if(image != null){
        request.files.add(http.MultipartFile(
          'image',
          http.ByteStream(image.openRead().cast()),
          await image.length(),
          filename: basename(image.path)
        ));
      }

      request.fields['user'] = json.encode(user);
      final response = await  request.send(); // enviar peticion
      if(response.statusCode == 401){
        Fluttertoast.showToast(msg: 'Tu Sesion Expiro');
        new SharedPref().logout(context);
      }
      return response.stream.transform(utf8.decoder);


    }
    catch(e){
      print('Error: $e}');
    }

  }

  Future<ResponseApi> create(Users user) async{

    try{

      Uri url = Uri.http(_url, '$_api/create');
      String BodyParams = json.encode(user);
      Map<String, String> headers ={
        'Content-type':'application/json',

      };
      final res = await http.post(url,headers:headers,body: BodyParams);
      final data = json.decode(res.body);
      ResponseApi resapi = ResponseApi.fromJson(data);
      return resapi;
    }
    catch(e){

      print('Error: $e');
      return null;

    }

  }

  Future<ResponseApi> login(String email, String password) async {
    try{

      Uri url = Uri.http(_url, '$_api/login');
      String BodyParams = json.encode({
        'email':email,
        'password': password
      });
      Map<String, String> headers ={
        'Content-type':'application/json',

      };
      final res = await http.post(url,headers:headers,body: BodyParams);
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