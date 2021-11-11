import 'dart:convert';


import 'package:delibery/src/api/enviroment.dart';
import 'package:delibery/src/models/biscategory.dart';
import 'package:delibery/src/models/user.dart';
import 'package:delibery/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;


class BiscategoriesPorvider{
String _url = Enviroment.API_Delibery;
String _api ='api/categories';

BuildContext context;
Users sessionuser;

Future init(BuildContext context, Users sessionuser){
  this.context = context;
  this.sessionuser = sessionuser;

}


Future<List<Biscategories>> getallbis() async {
  try {
    Uri url = Uri.http(_url, '$_api/getallbis');
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Authorization': sessionuser.sessionToken
    };
    final res = await http.get(url, headers: headers);

    if (res.statusCode == 401) {
      Fluttertoast.showToast(msg: 'Sesion Expirada');
      new SharedPref().logout(context);
    }
    final data = json.decode(res.body); //categorias
    Biscategories category = Biscategories.fromjsonList(data);
    return category.toList;
  }
  catch (e) {
    print('Error: $e');
    return [];
  }
}}