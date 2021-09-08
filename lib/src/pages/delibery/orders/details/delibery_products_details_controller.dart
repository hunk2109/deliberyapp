import 'package:delivey/src/models/orders.dart';
import 'package:delivey/src/models/products.dart';
import 'package:delivey/src/models/response_api.dart';
import 'package:delivey/src/models/user.dart';
import 'package:delivey/src/provider/order_provider.dart';
import 'package:delivey/src/provider/user_provider.dart';
import 'package:delivey/src/utils/mysnackbar.dart';
import 'package:delivey/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class DeliberyOrdersDetailsController{
  BuildContext context;
  Function refresh;
  Products products;

  int counter = 1;
  double productprice;
  SharedPref _sharedPref = SharedPref();
  List<Products> seletedPrducts = [];
  double total = 0;
  Order order;
  List<Users> users = [];
  Users user;
  UserProvider _usersProvider = new UserProvider();
  OrderProvider _orderProvider = new OrderProvider();
  String idDelibery;



  Future init(BuildContext context, Function refresh,Order order) async{
    this.context = context;
    this.refresh = refresh;
    this.order = order;
    user = Users.fromJson(await _sharedPref.read('user'));
    _usersProvider.init(context, sessionuser: user);
    _orderProvider.init(context, user);
    gettotal();
    getuserd();
    refresh();

  }

  void updateOrder() async{
    if(order.status == 'LISTO'){
      ResponseApi responseApi = await _orderProvider.updatetoDel(order);
      Fluttertoast.showToast(msg: responseApi.message,toastLength: Toast.LENGTH_LONG);

      if(responseApi.succes){

        Navigator.pushNamed(context, 'delibery/orders/maps', arguments: order.toJson());
      }


    }
    else{
      Navigator.pushNamed(context, 'delibery/orders/maps', arguments: order.toJson());
    }



  }

    void getuserd() async{
    users = await _usersProvider.getByDelibery();
    refresh();

    }
    void gettotal(){
    total = 0;

    order.products.forEach((product){

      total = total + (product.price*product.quantity);

    });


    refresh();
    }



}