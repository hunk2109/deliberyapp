import 'package:flutter/material.dart';

class ClientAdrresListController{
  BuildContext context;
  Function refresh;
  Future init(BuildContext context, Function refresh){
    this.context = context;
    this.refresh = refresh;
  }


  void gotoNewAddres(){
    Navigator.pushNamed(context, 'client/address/create');
  }

}