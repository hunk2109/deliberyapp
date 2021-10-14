import 'dart:async';

import 'package:delivey/src/models/categories.dart';
import 'package:delivey/src/models/user.dart';
import 'package:delivey/src/provider/products_provider.dart';
import 'package:delivey/src/provider/categories_provider.dart';
import 'package:flutter/material.dart';
import 'package:delivey/src/utils/shared_pref.dart';
import 'package:delivey/src/models/products.dart';
import 'package:delivey/src/pages/client/produts/details/client_producst_details_controller.dart';
import 'package:delivey/src/pages/client/produts/details/client_products_details_page.dart';

class ClientProductsListController{
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
  List<Products> seletedPrducts = [];




  Future init(BuildContext context, Function refresh ) async{
    this.context = context;
    this.refresh = refresh;
    users = Users.fromJson(await _sharedPref.read('user'));
    seletedPrducts = Products.fromJsonList(await _sharedPref.read('order')).toList;
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
        builder: (context) => ClientProdctsDetailsPages(products:products,)

    );
    refresh();
  }
  logout(){
    _sharedPref.logout(context);
  }

  void openDrawer(){
    key.currentState.openDrawer();
    refresh();
  }


  void onChangetxt(String text){
    Duration duration = Duration(milliseconds: 800);
    if(serchStopTyping != null){
      serchStopTyping.cancel();
      refresh();
    }
    serchStopTyping =  new Timer(duration, () {
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