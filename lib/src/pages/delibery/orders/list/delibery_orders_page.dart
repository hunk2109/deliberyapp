import 'package:delivey/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:delivey/src/pages/delibery/orders/list/delibery_orders_list_controller.dart';
import 'package:flutter/scheduler.dart';

class DeliberyOrdersListPage extends StatefulWidget {
  const DeliberyOrdersListPage ({Key key}) : super(key: key);

  @override
  _DeliberyOrdersListPageState createState() => _DeliberyOrdersListPageState();
}

class _DeliberyOrdersListPageState extends State<DeliberyOrdersListPage> {

  DeliberyOrdersListController _con = new DeliberyOrdersListController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context,refresh);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.key,
      appBar: AppBar(
        leading: _menuDrawer(),
      ),
      drawer: _drawer(),
      body: Center(

      ),
    );
  }

  Widget _menuDrawer(){
    return GestureDetector(
      onTap: _con.openDrawer,
      child: Container(
          margin: EdgeInsets.only(left: 20),
          alignment: Alignment.centerLeft,
          child:Image.asset('assets/img/menu.png', width: 20,height: 20,)
      ),
    );
  }

  Widget _drawer(){
    return Drawer(

      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration:BoxDecoration(
                  color: MyColors.prymaryColor
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children:[
                  Text(
                    'Nombre de Usuario',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                    maxLines: 1,
                  ),
                  Text(
                    'Correo',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[300],
                        fontWeight: FontWeight.bold
                    ),
                    maxLines: 1,
                  ),
                  Text(
                    'Telefono',
                    style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[200],
                        fontWeight: FontWeight.bold
                    ),
                    maxLines: 1,
                  ),

                  Container(
                    height: 60,
                    margin: EdgeInsets.only(top: 10),
                    child: FadeInImage(
                      image:AssetImage('assets/img/no-image.png'),
                      fit:BoxFit.contain,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder:AssetImage('assets/img/no-image.png'),
                    ),
                  )

                ],
              )
          ),
          _con.users != null ?
          _con.users.roles.length >1?
          ListTile(
            title: Text('Cambiar Rol'),
            trailing: Icon(Icons.person_outlined),

          ):Container():Container(),
          ListTile(
            title: Text('Cerrar Sesion'),
            trailing: Icon(Icons.power_settings_new),
            onTap: _con.logout,

          ),


        ],
      ),
    );
  }

  void refresh(){
    setState((){

    });
  }

}
