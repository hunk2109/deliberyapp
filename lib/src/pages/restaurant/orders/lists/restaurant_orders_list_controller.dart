

import 'package:delibery/src/models/orders.dart';
import 'package:delibery/src/models/user.dart';
import 'package:delibery/src/pages/restaurant/orders/details/client_products_order_details_page.dart';
import 'package:delibery/src/provider/order_provider.dart';
import 'package:delibery/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';


class RestaurentOrdersListController {
  BuildContext context;
  SharedPref _sharedPref = new SharedPref();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  Function refresh;
  Users users;
  List<String> categories = [
    'PAGADO',
    'LISTO',
    'EN CAMINO',
    'ENTREGADO',
  ];
  OrderProvider _orderProvider = new OrderProvider();
  bool isUpdated;



  Future init(BuildContext context, Function refresh ) async{
    this.context = context;
    this.refresh = refresh;
    users = Users.fromJson(await _sharedPref.read('user'));
    _orderProvider.init(context, users);
    refresh();
  }

  Future<List<Order>>getOrders(String status) async{
    return await _orderProvider.getByStatus(status);
  }
  logout(){
    _sharedPref.logout(context);
  }

  void openBottomSheet(Order order)async{
    isUpdated = await  showMaterialModalBottomSheet(
        context: context,
        builder: (context) => RestaurantOrdersDetailsPage(order: order)
    );
    if(isUpdated){
      refresh();
    }
  }
  void openDrawer(){
    key.currentState.openDrawer();
  }


  gotoRoles(){
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false) ;
  }

  void gotocategoriscreated(){

    Navigator.pushNamed(context, 'restaurant/category/create');

  }void gotocproductscreated(){

    Navigator.pushNamed(context, 'restaurant/products/create');
  }

  void gotoCreateRest(){
    Navigator.pushNamed(context, 'restaurant/create');

  }


}