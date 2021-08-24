import 'package:delivey/src/models/products.dart';
import 'package:delivey/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ClientProductsDetailsController{
  BuildContext context;
  Function refresh;
  Products products;

  int counter = 1;
  double productprice;
  SharedPref _sharedPref = SharedPref();
  List<Products> seletedPrducts = [];



  Future init(BuildContext context, Function refresh, Products products) async{
    this.context = context;
    this.refresh = refresh;
    this.products = products;
    productprice = products.price;
    //_sharedPref.remove('order');
    seletedPrducts = Products.fromJsonList(await _sharedPref.read('order')).toList;
    seletedPrducts.forEach((p) {
      print('Producto Selecionado: ${p.toJson()}');
    });

    refresh();
  }

  void addToBag(){
    int index = seletedPrducts.indexWhere((p) => p.id == products.id);
    if(index == -1){ // no existe Producto
      if(products.quantity == null){
        products.quantity = 1;
      }

      seletedPrducts.add(products);
    }

    else{
      seletedPrducts[index].quantity = counter;
    }
    _sharedPref.save('order',seletedPrducts);
    Fluttertoast.showToast(msg: 'Producto Agregado');
  }
  void additemc(){
    counter = counter +1;
    productprice = products.price * counter;
    products.quantity = counter;
    refresh();
  }

  void removitemc(){
    if(counter > 1){
      counter = counter -1;
      productprice = products.price * counter;
      products.quantity = counter;
      refresh();
    }

  }

  void close(){
    Navigator.pop(context);
  }
}