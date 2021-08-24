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



  Future init(BuildContext context, Function refresh ) async{
    this.context = context;
    this.refresh = refresh;
    users = Users.fromJson(await _sharedPref.read('user'));
    _categoriesProvider.init(context, users);
    _productsProvider.init(context, users);
    getCategories();
    refresh();
  }

  Future<List<Products>> getProducts(String id_category) async{
    return await _productsProvider.getAllCat(id_category);

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


  gotoRoles(){
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false) ;
} gotoUpdate(){
    Navigator.pushNamed(context, 'client/update') ;
}

void gotocheckorder(){
  Navigator.pushNamed(context, 'client/orders/create') ;

}
}