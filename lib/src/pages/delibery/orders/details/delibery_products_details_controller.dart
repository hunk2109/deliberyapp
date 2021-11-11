
import 'package:delivery/src/models/orders.dart';
import 'package:delivery/src/models/products.dart';
import 'package:delivery/src/models/response_api.dart';
import 'package:delivery/src/models/user.dart';
import 'package:delivery/src/provider/order_provider.dart';
import 'package:delivery/src/provider/push_notification_provider.dart';
import 'package:delivery/src/provider/user_provider.dart';
import 'package:delivery/src/utils/shared_pref.dart';
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
  String idClient;
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
    pushNotificationProvider.sendMesage(tokennot, data, 'Pedido Asignado ', 'Tu pedido  a Salido  ');
  }
  void updateOrder() async{
    if(order.status == 'LISTO'){
      ResponseApi responseApi = await _orderProvider.updatetoDel(order);
      Fluttertoast.showToast(msg: responseApi.message,toastLength: Toast.LENGTH_LONG);

      if(responseApi.succes){


        Users idClientUser = await _usersProvider.getByid(order.idClient);
        print('Token: ${idClientUser.notificationToken}');
        sendNotifications(idClientUser.notificationToken);
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