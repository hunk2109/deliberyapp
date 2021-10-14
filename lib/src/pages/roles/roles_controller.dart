import 'package:flutter/material.dart';
import 'package:delivey/src/models/user.dart';
import 'package:delivey/src/utils/shared_pref.dart';



class RolesController{
  BuildContext context;
  Function refresh;
  Users user;
  SharedPref _sharedPref = new SharedPref();

  Future init(BuildContext context, Function refresh,) async {
    this.context;
    this.refresh = refresh;

    user = Users.fromJson(await _sharedPref.read('user'));
    refresh();
  }

/*void goToPage(String ruta){
    Navigator.pushNamedAndRemoveUntil(context, ruta, (route) => false);
  }*/
}