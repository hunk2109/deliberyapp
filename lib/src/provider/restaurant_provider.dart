import 'dart:convert';
import 'dart:io';

import 'package:delivey/src/api/enviroment.dart';
import 'package:delivey/src/models/response_api.dart';
import 'package:delivey/src/models/restaurant.dart';
import 'package:delivey/src/utils/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:delivey/src/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class RestaurantsProvider{
  String _url = Enviroment.API_Delibery;
  String _api ='api/restaurant';

  BuildContext context;
  Users sessionuser;

  Future init(BuildContext context, Users sessionuser){
    this.context = context;
    this.sessionuser = sessionuser;

  }

 /* Future<List<Category>> getall() async {
    try{
      Uri url = Uri.http(_url, '$_api/getall');
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
      Category category = Category.fromJsonList(data);
      return category.toList;


    }
    catch(e){
      print('Error: $e');
      return [];
    }
  }*/
  Future<Stream> create(Restaurant restaurant, File image ) async{

    try{

      Uri url = Uri.http(_url, '$_api/create');
      final request =http.MultipartRequest('POST',url);
      request.headers['Authorization'] = sessionuser.sessionToken;

      if(image != null){
        request.files.add(http.MultipartFile(
            'image',
            http.ByteStream(image.openRead().cast()),
            await image.length(),
            filename: basename(image.path)
        ));
      }

      request.fields['restaurant'] = json.encode(restaurant);
      final response = await  request.send(); // enviar peticion
      return response.stream.transform(utf8.decoder);

    }
    catch(e){

      print('Error: $e');
      return null;

    }

  }
}