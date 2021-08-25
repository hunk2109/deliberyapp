import 'package:delivey/src/utils/my_colors.dart';
import 'package:delivey/src/widgets/no_data_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:delivey/src/pages/client/address/list/client_address_list_controller.dart';

class ClientAddrressListePage extends StatefulWidget {
  @override
  _ClientAddrressListPageState createState() => _ClientAddrressListPageState();
}

class _ClientAddrressListPageState extends State<ClientAddrressListePage> {

  ClientAdrresListController _con = new ClientAdrresListController();
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
        title: Text('Direccion'),
        actions: [
          iconsAdd(),
        ],
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            _textSelectAdrres(),
            Container(
              margin: EdgeInsets.only(top: 30),
                child:
                NodataWidget(
                    text:'Sin Direcciones, agrega una '
                )

            ),
            _bottonNewAddres(),
          ],
        ),
      ),
      bottomNavigationBar: _bottonAddres(),
    );
  }

  Widget _bottonNewAddres(){
    return Container(
      height: 40,

      child: ElevatedButton(
        onPressed: (){_con.gotoNewAddres();},
        child: Text(
            'Nueva Direccion'
        ),
        style: ElevatedButton.styleFrom(

          primary: Colors.blue,

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
        onPressed: (){},
        child: Text(
          'ACEPTAR'
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
  Widget _textSelectAdrres(){
   return Container(
     alignment: Alignment.centerLeft,
     margin: EdgeInsets.symmetric(horizontal: 40,vertical: 30),
     child: Text('Elige donde quieres resivir tu pedido',
     style:  TextStyle(
       fontSize: 19,
       fontWeight: FontWeight.bold,

     ),
     ),

    );

  }
  Widget iconsAdd(){
    return IconButton(
        onPressed: _con.gotoNewAddres,
        icon: Icon(Icons.add,color: Colors.white));
  }

  void refresh(){
    setState(() {

    });
  }
}
