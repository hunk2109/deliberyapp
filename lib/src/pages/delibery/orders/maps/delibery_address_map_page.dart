import 'package:delivey/src/utils/my_colors.dart';
import 'package:delivey/src/widgets/no_data_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:delivey/src/pages/delibery/orders/maps/delibery_address_map_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeliberyAddrressMaptePage extends StatefulWidget {
  @override
  _DeliberyAddrressMaptePageState createState() => _DeliberyAddrressMaptePageState();
}

class _DeliberyAddrressMaptePageState extends State<DeliberyAddrressMaptePage> {

  DeliberyAdrresMapController _con = new DeliberyAdrresMapController();
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


      body: Stack(
        children: [
          _googlemaps(),


          Container(
            alignment:  Alignment.bottomCenter,
            child: _bottonAddres(),
          ),
        ],
      ),


    );


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
      markers: Set<Marker>.of(_con.markers.values),

    );
  }


  void refresh() {
    setState(() {

    });
  }
}
