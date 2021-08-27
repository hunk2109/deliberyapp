import 'package:delivey/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:delivey/src/pages/client/address/create/client_address_create_controller.dart';

class ClientAddrressCreatePage extends StatefulWidget {
  @override
  _ClientAddrressCreatePageState createState() => _ClientAddrressCreatePageState();
}

class _ClientAddrressCreatePageState extends State<ClientAddrressCreatePage> {

  ClientAdrresCreateController _con = new ClientAdrresCreateController();
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
        title: Text('Nueva Direccion'),
      ),

      bottomNavigationBar: _bottonAddres(),
      body: Column(
        children: [
          _textNewtAdrres(),
          _textFieldAddress(),
          _textFielNeighborhood(),
          _textFielReference(),
        ],
      ),
    );
  }

  Widget _textFieldAddress(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
      child: TextField(
        controller: _con.adressController,
        decoration: InputDecoration(
          labelText: 'Direccion',
          suffixIcon: Icon(
            Icons.location_on,
            color: MyColors.prymaryColor,
          )
        ),
      ),
    );
  }
  Widget _textFielReference(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
      child: TextField(
        controller: _con.referenController,
        onTap: _con.openmap,
        autofocus: false,
        focusNode: AllwaysDisableFocusNode(),
        decoration: InputDecoration(
            labelText: 'Punto de Referencia',
            suffixIcon: Icon(
              Icons.map,
              color: MyColors.prymaryColor,
            )
        ),
      ),
    );
  }
  Widget _textFielNeighborhood(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
      child: TextField(
        controller: _con.neighborController,
        decoration: InputDecoration(
            labelText: 'Barrio',
            suffixIcon: Icon(
              Icons.location_city,
              color: MyColors.prymaryColor,
            )
        ),
      ),
    );
  }
  Widget _textNewtAdrres(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 40,vertical: 30),
      child: Text('Crea una Nueva Direccion',
        style:  TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.bold,

        ),
      ),

    );

  }

  Widget _bottonAddres(){
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 30,horizontal: 50),
      child: ElevatedButton(
        onPressed: _con.createeAddress,
        child: Text(
            'Crear Direccion'
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

  void refresh(){
    setState(() {
      
    });
  }
}

class AllwaysDisableFocusNode extends FocusNode{
  @override
  bool get hasFocus => false;
}
