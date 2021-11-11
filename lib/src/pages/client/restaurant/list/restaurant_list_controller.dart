import 'dart:async';



import 'package:delibery/src/models/categories.dart';
import 'package:delibery/src/models/products.dart';
import 'package:delibery/src/models/user.dart';
import 'package:delibery/src/pages/client/produts/details/client_products_details_page.dart';
import 'package:delibery/src/provider/categories_provider.dart';
import 'package:delibery/src/provider/products_provider.dart';
import 'package:delibery/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';


class RestaurentListController{
  BuildContext context;
  SharedPref _sharedPref = new SharedPref();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  Function refresh;
  Users users;
  List<Category> categories = [];
  ProductsProvider _productsProvider = new  ProductsProvider();
  CategoriesProvider _categoriesProvider = new CategoriesProvider();
  Timer serchStopTyping;
  String productName = '';



  Future init(BuildContext context, Function refresh ) async{
    this.context = context;
    this.refresh = refresh;
    users = Users.fromJson(await _sharedPref.read('user'));
    _categoriesProvider.init(context, users);
    _productsProvider.init(context, users);
    getCategories();
    refresh();
  }

  Future<List<Products>> getProducts(String id_category,String productname) async{
    if(productName.isEmpty){
      return await _productsProvider.getAllCat(id_category);

    }
    else {
      return await _productsProvider.getAllCatandName(id_category, productname);
    }


  }

  void getCategories() async{

    categories = await _categoriesProvider.getall();
    refresh();
  }
  
  void openBottonSheet(Products products)
  {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => ClientProdctsDetailsPages(products:products  ,)
    );
  }
  logout(){
    _sharedPref.logout(context);
  }

  void openDrawer(){
    key.currentState.openDrawer();
  }


  void onChangetxt(String text){
    Duration duration = Duration(milliseconds: 800);
    if(serchStopTyping != null){
      serchStopTyping.cancel();
      refresh();
    }
    serchStopTyping = Timer(duration, () {
      productName = text;
      refresh();
      print('Texto Completo: ${text}');
    });


  }
  gotoRoles(){
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false) ;
}
gotoUpdate(){
    Navigator.pushNamed(context, 'client/update') ;
}
gotoOrdersList(){
    Navigator.pushNamed(context, 'client/orders/list') ;
}

void gotocheckorder(){
  Navigator.pushNamed(context, 'client/orders/create') ;

}
}