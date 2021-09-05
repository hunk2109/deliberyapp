import 'package:delivey/src/pages/client/orders/list/client_orders_page.dart';
import 'package:delivey/src/pages/client/orders/maps/client_address_map_page.dart';
import 'package:delivey/src/pages/client/payments/create/client_payments_page.dart';
import 'package:delivey/src/pages/restaurant/products/create/restaurant_products_create_page.dart';
import 'package:flutter/material.dart';
import 'package:delivey/src/pages/login/login_page.dart';
import 'package:delivey/src/utils/my_colors.dart';
import 'src/pages/register/regis_page.dart';
import 'package:delivey/src/pages/client/produts/list/client_produts_list_page.dart';
import 'package:delivey/src/pages/restaurant/orders/lists/restaurant_orders_list_page.dart';
import 'src/pages/delibery/orders/list/delibery_orders_page.dart';
import 'src/pages/roles/roles_pages.dart';
import 'package:delivey/src/pages/client/update/client_update_page.dart';
import 'package:delivey/src/pages/restaurant/category/create/restaurant_category_create_page.dart';
import 'package:delivey/src/pages/client/orders/create/client_products_order_create_page.dart';
import 'package:delivey/src/pages/client/address/list/client_address_list_page.dart';
import 'package:delivey/src/pages/client/address/create/client_address_create_page.dart';
import 'package:delivey/src/pages/client/address/maps/client_address_map_page.dart';
import 'package:delivey/src/pages/restaurant/create/restaurant_create_page.dart';
import 'package:delivey/src/pages/restaurant/orders/details/client_products_order_details_page.dart';
import 'package:delivey/src/pages/delibery/orders/maps/delibery_address_map_page.dart';






void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {

  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delibery',
      initialRoute: 'login',
      routes: {
        'login' :(BuildContext context) => Loginpage(),
        'register' :(BuildContext context) => RegisterPage(),
        'roles': (BuildContext context) => RolesPage(),
        'client/produts/list':(BuildContext context)=> ClientProdutsListPage(),
        'client/address/list':(BuildContext context)=> ClientAddrressListePage(),
        'client/address/create':(BuildContext context)=> ClientAddrressCreatePage(),
        'client/payments/create':(BuildContext context)=> ClientPaymentsCreatePage(),
        'client/address/maps':(BuildContext context)=> ClientAddrressMaptePage(),
        'client/orders/list':(BuildContext context)=> ClientOrdersListPage(),
        'client/orders/maps':(BuildContext context)=> ClientMaptePage(),
        'client/orders/create':(BuildContext context)=> ClientOrdersCreatePge(),
        'client/update':(BuildContext context)=> ClientUpdatePage(),
        'restaurant/orders/list':(BuildContext context)=> RestaurantOrdersListPage(),
        'restaurant/category/create':(BuildContext context)=> RestaurantCategoryCreatePage(),
        'restaurant/products/create':(BuildContext context)=> RestaurantProductsCreatePage(),
        'delibery/orders/list':(BuildContext context)=> DeliberyOrdersListPage(),
        'delibery/orders/maps':(BuildContext context)=> DeliberyAddrressMaptePage(),
        'restaurant/create':(BuildContext context)=> RestaurantCreateePage(),
        'restaurant/details':(BuildContext context)=> RestaurantOrdersDetailsPage(),

      },
      theme: ThemeData(
        primaryColor: MyColors.prymaryColor,
        appBarTheme: AppBarTheme(elevation: 0)
      )

    );

  }
}
