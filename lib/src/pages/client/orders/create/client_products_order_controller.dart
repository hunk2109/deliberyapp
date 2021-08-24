import 'package:delivey/src/models/products.dart';
import 'package:delivey/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ClientProductsOrdersCreateController{
  BuildContext context;
  Function refresh;
  Products products;

  int counter = 1;
  double productprice;
  SharedPref _sharedPref = SharedPref();
  List<Products> seletedPrducts = [];
  double total = 0;



  Future init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    seletedPrducts = Products.fromJsonList(await _sharedPref.read('order')).toList;
    refresh();
    gettotal();
    }

    void gettotal(){
    total = 0;
    seletedPrducts.forEach((producs) {
      total = total +(producs.quantity*producs.price);
    });

    refresh();
    }

    void additems(Products products){
      int index = seletedPrducts.indexWhere((p) => p.id == products.id);
      seletedPrducts[index].quantity = seletedPrducts[index].quantity +1;
      _sharedPref.save('order', seletedPrducts);
      gettotal();


    }void removitems(Products products){
    if(products.quantity >1) {
      int index = seletedPrducts.indexWhere((p) => p.id == products.id);
      seletedPrducts[index].quantity = seletedPrducts[index].quantity - 1;
      _sharedPref.save('order', seletedPrducts);
      gettotal();
    }

    }void deleteitems(Products products){
    seletedPrducts.removeWhere((p) => p.id == products.id);
    _sharedPref.save('order', seletedPrducts);
    gettotal();


  }
}