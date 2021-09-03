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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _con.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.53 ,
              child: _googlemaps()

          ),


          SafeArea(
            child: Column(
              children: [
                _buttonCenter(),
                Spacer(),
                _carInfo(),

              ],
            ),
          ),
        ],
      ),


    );


  }


  Widget _BottonConfirm(){
    return Container(
        margin: EdgeInsets.only(left: 30,right: 30,top: 5,bottom: 5),
        child: ElevatedButton(
          onPressed: _con.updateToDelivered,
          style: ElevatedButton.styleFrom(
              primary: MyColors.prymaryColor,
              padding: EdgeInsets.symmetric(vertical: 5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
              )


          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  child: Text(
                      'Entregar Producto',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,

                      )
                  ),
                ),
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.only(left: 50,top: 3),
                  height: 30,
                  child: Icon(Icons.check_circle,
                      color: Colors.white,
                      size: 30),
                ),
              ),



            ],
          ),
        )
    );
  }
  Widget _carInfo(){
    return Container(
      height: MediaQuery.of(context).size.height *0.47,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),

        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0,3),
          ),
        ],
      ),
      child: Column(
        children: [
          _listInfo(_con.order?.address?.neightborhood??'', 'Barrio', Icons.my_location),
          _listInfo(_con.order?.address?.address??'', 'Direccion', Icons.location_on),
          Divider(color: Colors.grey[400],endIndent: 30, indent: 30,),
          _clientInfo(),
          _BottonConfirm(),


        ],
      ),
    );
  }
  Widget _clientInfo(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35,vertical: 20),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            child: FadeInImage(
              image: _con.order?.client?.image  != null
                  ?NetworkImage(_con.order?.client?.image):

              AssetImage('assets/img/no-image.png'),
              fit: BoxFit.cover,
              fadeInDuration: Duration(milliseconds: 50),
              placeholder:AssetImage('assets/img/no-image.png'),
            ),

          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text('${_con.order?.client?.name??''} ${_con.order?.client?.lastname??''}',
            style:TextStyle(
             color: Colors.black,
              fontSize: 17,


            ),
              maxLines: 1,

            ),
          ),

          Spacer(),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.grey[300]
            ),
            child: IconButton(
              onPressed: _con.call,
              icon: Icon(Icons.phone,
              color: Colors.black,),
            ),
          ),
        ],
      ),
    );
  }
  Widget _listInfo(String title, String subtitle, IconData iconData){

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: ListTile(
        title: Text(
            title ??'',
        style: TextStyle(
          fontSize: 13
        ),
        ),
        subtitle: Text(subtitle),
        trailing: Icon(iconData),
      ),
    );
  }
  Widget _buttonCenter(){
    return GestureDetector(
      onTap: (){},
      child: Container(
        alignment: Alignment.centerRight,
        margin: EdgeInsets.symmetric(horizontal: 5) ,
        child: Card(
          shape: CircleBorder(),
          color: Colors.white,
          elevation: 4.0,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Icon(Icons.location_searching_outlined,
              color: Colors.grey[600],
              size: 20,
            ),


          ),
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
      polylines: _con.polylines,


    );
  }


  void refresh() {
    if(!mounted) return;
    setState(() {

    });
  }
}
