import 'package:delivey/src/models/address.dart';
import 'package:delivey/src/models/orders.dart';
import 'package:delivey/src/models/products.dart';
import 'package:delivey/src/models/response_api.dart';
import 'package:delivey/src/models/user.dart';
import 'package:delivey/src/provider/address_provider.dart';
import 'package:delivey/src/provider/order_provider.dart';
import 'package:delivey/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';

class ClientPaymentListController{
  BuildContext context;
  Function refresh;
  List<Address> address = [];
  AddressProvider _addressProvider = new AddressProvider();
  Users users;
  SharedPref _sharedPref = new SharedPref();
  int radiovalue = 0;
  bool isCreated;
  List<Products> seletedPrducts = [];


OrderProvider _orderProvider = new OrderProvider();
  Future init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    users = Users.fromJson(await _sharedPref.read('user'));
    _addressProvider.init(context, users);
    _orderProvider.init(context, users);
    refresh();

  }

  Future<List<Address>> getAddress() async {

    address = await _addressProvider.getall(users.id);
    Address a = Address.fromJson(await _sharedPref.read('address')?? {});
    int index = address.indexWhere((ad) => ad.id==a.id);
    if(index != -1){
      radiovalue = index;
    }
    print('Valor Guardado: ${a.toJson()}');
    return address;

  }

  void createOrder() async {
    Address a = Address.fromJson(await _sharedPref.read('address')?? {});
    List<Products>  seletedPrducts = Products.fromJsonList(await _sharedPref.read('order')).toList;
    Order order = new Order(
      idClient:  users.id,
      idAddress: a.id,
      products: seletedPrducts,

    );

    ResponseApi responseApi = await _orderProvider.create(order);


    Navigator.pushNamed(context, 'client/payments/create');
      print('Respuesta: ${responseApi.message}');


  }
  void handleRadioValuesChange(int value) async {
    radiovalue = value;
    _sharedPref.save('address', address[value]);
    print('Valor: $radiovalue');
    refresh();

  }
  void gotoNewAddres() async{
   var resul = await Navigator.pushNamed(context, 'client/address/create');

   if(resul  != null){
     if(resul = true){
       refresh();
     }
   }
  }

}