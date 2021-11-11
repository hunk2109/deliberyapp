

import 'package:delibery/src/models/categories.dart';
import 'package:delibery/src/models/response_api.dart';
import 'package:delibery/src/models/user.dart';
import 'package:delibery/src/provider/categories_provider.dart';
import 'package:delibery/src/utils/mysnackbar.dart';
import 'package:delibery/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';


class RestauranrCategoryCreateControoler{

  BuildContext context;
  Function refresh;
  SharedPref _sharedPref = new SharedPref();

  TextEditingController namecontroller =new TextEditingController();
  TextEditingController desccontroller = new TextEditingController();
  CategoriesProvider _categoriesProvider = new CategoriesProvider();
  Users user;

  Future init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    user = Users.fromJson(await _sharedPref.read('user'));
    _categoriesProvider.init(context, user);
  }

  void createCategory() async {
    String name  = namecontroller.text;
    String description  = desccontroller.text;

    if(name.isEmpty || description.isEmpty){

      MySnackbar.show(context, 'Debes llenar todos lo campos');
      return;

    }
    Category category = new Category(
        name: name,
        description:  description
    );

    ResponseApi responseApi = await _categoriesProvider.create(category);
    MySnackbar.show(context, responseApi.message);
    if(responseApi.succes = true){
      namecontroller.text ='';
      desccontroller.text = '';

    }
  }
}