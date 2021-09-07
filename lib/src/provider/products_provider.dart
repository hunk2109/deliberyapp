import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:delivey/src/api/enviroment.dart';
import 'package:delivey/src/models/products.dart';
import 'package:delivey/src/models/response_api.dart';
import 'package:delivey/src/utils/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:delivey/src/models/user.dart';
import 'package:delivey/src/models/categories.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
class ProductsProvider {

  String _url = Enviroment.API_Delibery;
  String _api = 'api/products';

  BuildContext context;
  Users sessionuser;

  Future init(BuildContext context, Users sessionuser) {
    this.context = context;
    this.sessionuser = sessionuser;
  }

  Future<List<Products>> getAllCat(String idCategory) async {
    try{
      Uri url = Uri.http(_url, '$_api/findByCategory/$idCategory');
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
      Products products = Products.fromJsonList(data);
      return products.toList;


    }
    catch(e){
      print('Error: $e');
      return [];
    }
  }Future<List<Products>> getAllCatandName(String idCategory, String product_name) async {
    try{
      Uri url = Uri.http(_url, '$_api/findByCategoryandNamey/$idCategory/$product_name');
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
      Products products = Products.fromJsonList(data);
      return products.toList;


    }
    catch(e){
      print('Error: $e');
      return [];
    }
  }
  Future<Stream> create(Products products,List<File> images) async{
    try{
      Uri url = Uri.http(_url, '$_api/create');
      final request =http.MultipartRequest('POST',url);
      request.headers['Authorization'] = sessionuser.sessionToken;

      for (int i = 0; i < images.length; i++){
        request.files.add(http.MultipartFile(
            'image',
            http.ByteStream(images[i].openRead().cast()),
            await images[i].length(),
            filename: basename(images[i].path)
        ));

      }

      request.fields['product'] = json.encode(products);
      final response = await  request.send(); // enviar peticion
      return response.stream.transform(utf8.decoder);


    }
    catch(e){
      print('Error: $e}');
    }

  }

}