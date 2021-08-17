import 'package:flutter/material.dart';
import 'package:delivey/src/pages/client/produts/list/clint_products_list_controller.dart';
import 'package:flutter/scheduler.dart';
import 'package:delivey/src/utils/my_colors.dart';


class ClientProdutsListPage extends StatefulWidget {
  const ClientProdutsListPage({Key key}): super(key: key);

  @override
  _ClientProdutsListPageState createState() => _ClientProdutsListPageState();
}

class _ClientProdutsListPageState extends State<ClientProdutsListPage> {
  ClientProductsListController _con = new ClientProductsListController();

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
              '${_con.users?.name ?? ''} ${_con.users?.lastname ?? ''}',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
                maxLines: 1,
              ),
              Text(
                '${_con.users?.email??''}',
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[300],
                    fontWeight: FontWeight.bold
                ),
                maxLines: 1,
              ),
              Text(
                '${_con.users?.phone?? ''}',
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
                  image: _con.users?.image != null
                      ? NetworkImage(_con.users?.image)
                 : AssetImage('assets/img/no-image.png'),
                  fit:BoxFit.contain,
                  fadeInDuration: Duration(milliseconds: 50),
                  placeholder:AssetImage('assets/img/no-image.png'),
                ),
              )

            ],
          )
          ),
         ListTile(
           title: Text('Editar Perfil'),
           trailing: Icon(Icons.edit_outlined),

         ),
          ListTile(
            title: Text('Mis pedidos'),
            trailing: Icon(Icons.shopping_cart_outlined),


          ),
          _con.users != null ?
              _con.users.roles.length >1?
          ListTile(
            onTap: _con.gotoRoles,
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
