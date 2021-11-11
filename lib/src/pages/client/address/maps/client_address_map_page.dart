
import 'package:delibery/src/pages/client/address/maps/client_address_map_controller.dart';
import 'package:delibery/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClientAddrressMaptePage extends StatefulWidget {
  @override
  _ClientAddrressMaptePageState createState() => _ClientAddrressMaptePageState();
}

class _ClientAddrressMaptePageState extends State<ClientAddrressMaptePage> {

  ClientAdrresMapController _con = new ClientAdrresMapController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);

    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Ubica tu direccion en el mapa'),
        actions: [

        ],
      ),
      body: Stack(
        children: [
          _googlemaps(),
          Container(
            alignment: Alignment.center,
            child: _iconlocatio(),


          ),
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top:30),
            child: _carAddress(),
          ),
          Container(
            alignment:  Alignment.bottomCenter,
            child: _bottonAddres(),
          ),
        ],
      ),


    );


  }

  Widget _iconlocatio(){
    return Image.asset(
      'assets/img/my_location.png',
      width: 65,
      height: 65,);
  }
  Widget _bottonAddres(){
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 30,horizontal: 70),
      child: ElevatedButton(
        onPressed: _con.selectRefpoint,
        child: Text(
            'Seleccionar este punto'
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          primary: MyColors.prymaryColor,

        ),
      ),
    );
  }
  Widget _carAddress(){
    return  Container(
      child: Card(
        color: Colors.grey[800],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
        child: Container(
          padding:  EdgeInsets.symmetric(horizontal: 20,vertical: 15),
          child: Text(_con.addressName ??'',
            style:  TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold

            ),),
        ),
      ),
    );

  }
  Widget _googlemaps(){
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _con.initPosition,
      onMapCreated: _con.onMapCreated,
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
      onCameraMove: (position){
        _con.initPosition = position;
      },
      onCameraIdle: ()async{
        await _con.setLocationDraggableIng();
      },
    );
  }


  void refresh() {
    setState(() {

    });
  }
}