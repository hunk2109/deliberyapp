import 'package:flutter/material.dart';
import 'package:delivey/src/pages/login/login_page.dart';
import 'package:delivey/src/utils/my_colors.dart';
import 'src/pages/register/regis_page.dart';
import 'package:delivey/src/pages/client/produts/list/client_produts_list_page.dart';
import 'package:delivey/src/pages/restaurant/orders/lists/restaurant_orders_list_page.dart';
import 'src/pages/delibery/orders/list/delibery_orders_page.dart';
import 'src/pages/roles/roles_pages.dart';
import 'package:delivey/src/pages/client/update/client_update_page.dart';






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
        'client/update':(BuildContext context)=> ClientUpdatePage(),
        'restaurant/orders/list':(BuildContext context)=> RestaurantOrdersListPage(),
        'delibery/orders/list':(BuildContext context)=> DeliberyOrdersListPage(),
      },
      theme: ThemeData(
        primaryColor: MyColors.prymaryColor
      )

    );

  }
}
