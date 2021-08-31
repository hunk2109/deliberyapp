import 'package:delivey/src/models/orders.dart';
import 'package:delivey/src/models/products.dart';
import 'package:delivey/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class RestaurantOrdersDetailsController{
  BuildContext context;
  Function refresh;
  Products products;

  int counter = 1;
  double productprice;
  SharedPref _sharedPref = SharedPref();
  List<Products> seletedPrducts = [];
  double total = 0;
  Order order;



  Future init(BuildContext context, Function refresh,Order order) async{
    this.context = context;
    this.refresh = refresh;
    this.order = order;
    refresh();
    gettotal();
    }

    void gettotal(){
    total = 0;

    order.products.forEach((product){

      total = (product.price*product.quantity);

    });


    refresh();
    }



}