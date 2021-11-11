

import 'package:delibery/src/models/orders.dart';
import 'package:delibery/src/models/products.dart';
import 'package:delibery/src/models/response_api.dart';
import 'package:delibery/src/models/user.dart';
import 'package:delibery/src/provider/order_provider.dart';
import 'package:delibery/src/provider/push_notification_provider.dart';
import 'package:delibery/src/provider/user_provider.dart';
import 'package:delibery/src/utils/shared_pref.dart';
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
  List<Users> users = [];
  Users user;
  UserProvider _usersProvider = new UserProvider();
  OrderProvider _orderProvider = new OrderProvider();
  String idDelibery;
  PushNotificationProvider pushNotificationProvider = new PushNotificationProvider();



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

  void sendNotifications(String tokennot){
    Map<String, dynamic> data = {
      'click_action':'FLUTTER_NOTIFICATION_CLICK'
    };
    pushNotificationProvider.sendMesage(tokennot, data, 'Pedido Asignado', 'Te han asignado un pedido');
  }
  void updateOrder() async{
    if(idDelibery != null){
      order.idDelibery = idDelibery;
      ResponseApi responseApi = await _orderProvider.update(order);
      Users deliberyUser = await _usersProvider.getByid(order.idDelibery);
      print('Token: ${deliberyUser.notificationToken}');
      sendNotifications(deliberyUser.notificationToken);
      Fluttertoast.showToast(msg: responseApi.message,toastLength: Toast.LENGTH_LONG);
      Navigator.pop(context,true);
      refresh();

    }

    else{
      Fluttertoast.showToast(msg: 'Selecciona un Repartidor');
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