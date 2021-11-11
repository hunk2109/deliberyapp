import 'package:delivery/src/models/user.dart';
import 'package:delivery/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';




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