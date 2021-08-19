import 'package:delivey/src/models/categories.dart';
import 'package:delivey/src/models/response_api.dart';
import 'package:delivey/src/models/user.dart';
import 'package:delivey/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:delivey/src/utils/mysnackbar.dart';
import 'package:delivey/src/provider/categories_provider.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class RestauranrProductsCreateController{

  BuildContext context;
  Function refresh;
  SharedPref _sharedPref = new SharedPref();

  TextEditingController namecontroller =new TextEditingController();
  TextEditingController desccontroller = new TextEditingController();
  MoneyMaskedTextController pricecontroller = MoneyMaskedTextController();

  CategoriesProvider _categoriesProvider = new CategoriesProvider();
  Users user;

  Future init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    user = Users.fromJson(await _sharedPref.read('user'));
    _categoriesProvider.init(context, user);
  }

  void createProducts() async {
    String name = namecontroller.text;
    String description = desccontroller.text;

    if (name.isEmpty || description.isEmpty) {
      MySnackbar.show(context, 'Debes llenar todos lo campos');
      return;
    }
  }
}