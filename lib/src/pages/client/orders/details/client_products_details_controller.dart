
import 'package:delivery/src/models/orders.dart';
import 'package:delivery/src/models/products.dart';
import 'package:delivery/src/models/user.dart';
import 'package:delivery/src/provider/order_provider.dart';
import 'package:delivery/src/provider/user_provider.dart';
import 'package:delivery/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ClientOrdersDetailsController{
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

        Navigator.pushNamed(context, 'client/orders/maps', arguments: order.toJson());
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