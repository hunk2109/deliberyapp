
import 'package:delibery/src/models/address.dart';
import 'package:delibery/src/models/response_api.dart';
import 'package:delibery/src/models/user.dart';
import 'package:delibery/src/pages/client/address/maps/client_address_map_page.dart';
import 'package:delibery/src/provider/address_provider.dart';
import 'package:delibery/src/utils/mysnackbar.dart';
import 'package:delibery/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';


class ClientAdrresCreateController{
  BuildContext context;
  Function refresh;
  double _deliberyPositionDistance;


  TextEditingController referenController = new TextEditingController();
  TextEditingController adressController = new TextEditingController();
  TextEditingController neighborController = new TextEditingController();
  Map<String , dynamic> pointRef;

  AddressProvider _addressProvider = new AddressProvider();
  Users users;
  SharedPref _sharedPref = new SharedPref();
  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    users = Users.fromJson(await _sharedPref.read('user'));
    _addressProvider.init(context, users);
  }

  /*void isCloseToDelivered(){
    _deliberyPositionDistance = Geolocator.distanceBetween(_position.latitude,
        _position.longitude,
        order.address.lat,
        order.address.lng
    );*/
  void createeAddress() async {
    String addresstxt = adressController.text;
    String neighborotxt = neighborController.text;
    String mapstxt = referenController.text;
    double lat = pointRef['lat']??0;
    double lng = pointRef['lng']??0;

    if(addresstxt.isEmpty ||neighborotxt.isEmpty|| lat ==0 || lng ==0 ||mapstxt.isEmpty){
      MySnackbar.show(context, 'Completa todos los datos');


      return;
    }

    Address address = new Address(

        address: addresstxt,
        neightborhood: neighborotxt,
        lat: lat,
        lng: lng,
        idUser: users.id

    );

    ResponseApi  responseApi = await _addressProvider.create(address);
    if(responseApi.succes ){
      address.id = responseApi.data;
      _sharedPref.save('address', address);

      Fluttertoast.showToast(msg: responseApi.message);
      Navigator.pop(context, true);
    }



  }

  void openmap() async {
    pointRef = await  showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: false,
        enableDrag: false,
        context: context,
        builder: (context) => ClientAddrressMaptePage()
    );

    if(pointRef != null){
      referenController.text = pointRef['address'];
    }
  }

}