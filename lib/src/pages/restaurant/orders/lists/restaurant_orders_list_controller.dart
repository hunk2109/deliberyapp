import 'package:delivey/src/models/user.dart';
import 'package:flutter/material.dart';
import 'package:delivey/src/utils/shared_pref.dart';

class RestaurentOrdersListController {
  BuildContext context;
  SharedPref _sharedPref = new SharedPref();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  Function refresh;

  Users users;



  Future init(BuildContext context, Function refresh ) async{
    this.context = context;
    this.refresh = refresh;
    users = Users.fromJson(await _sharedPref.read('user'));
    refresh();
  }

  logout(){
    _sharedPref.logout(context);
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