import 'package:delivey/src/models/orders.dart';
import 'package:delivey/src/utils/my_colors.dart';
import 'package:delivey/src/widgets/no_data_widgets.dart';
import 'package:flutter/material.dart';
import 'package:delivey/src/pages/delibery/orders/list/delibery_orders_list_controller.dart';
import 'package:flutter/scheduler.dart';
import 'package:delivey/src/utils/relative_time_util.dart';

class DeliberyOrdersListPage extends StatefulWidget {

  const DeliberyOrdersListPage ({Key key}) : super(key: key);

  @override
  _DeliberyOrdersListPageState createState() => _DeliberyOrdersListPageState();


}

class _DeliberyOrdersListPageState  extends State<DeliberyOrdersListPage> {

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
    return DefaultTabController(
      length: _con.categories?.length,
      child: Scaffold(
          key: _con.key,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(100),
              child:AppBar(
                automaticallyImplyLeading: false,
                flexibleSpace: Column(
                  children: [
                    SizedBox(height: 40,),
                    _menuDrawer(),
                    //SizedBox(height: 30,),
                  ],
                ),
                bottom: TabBar(
                  indicatorColor: MyColors.prymaryColor,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey[400],
                  isScrollable: true,
                  tabs: List<Widget>.generate(_con.categories.length,(index){
                    return  Tab(

                      child: Text(_con.categories[index] ?? ''),

                    );


                  }),
                ),
                backgroundColor: Colors.white ,

              )
          ),
          drawer: _drawer(),
          body: TabBarView(
            children: _con.categories.map((String status) {
              // return _carorder(null);
              return FutureBuilder(
                  future: _con.getOrders(status),

                  builder: (context, AsyncSnapshot<List<Order>> snapshot){
                    if(snapshot.hasData){
                      if(snapshot.data.length > 0){
                        return ListView.builder(
                            itemCount: snapshot.data?.length??0,
                            itemBuilder: (_,index){
                              return _carorder(snapshot.data[index]);
                            }
                        );
                      }
                      else{
                        return NodataWidget(text:'No hay Ordenes',

                        );
                      }
                    }
                    else{
                      return NodataWidget(text:'No hay Ordenes',);
                    }


                  }
              );
              //_carProduct();
            }
            ).toList(),

          )
      ),
    );
  }

  Widget _carorder(Order order){
    return GestureDetector(
      onTap: (){_con.openBottomSheet(order);},
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
        height:160,
        child: Card(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),

          ),
          child: Stack(
            children: [
              Positioned(
                child:
                Container(
                  height: 30,
                  width: MediaQuery.of(context).size.width *1,
                  decoration: BoxDecoration(

                      color: MyColors.prymaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),

                      )
                  ),
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text('Orden #${order.id}',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),

                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40,left: 15,right: 15),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      width: double.infinity,
                      child: Text(
                        'Pedido: ${RelativeTimeUtil.getRelativeTime(order.timestamp??'')}',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      width: double.infinity,
                      child: Text(
                        'Ciente: ${order.client?.name??''} ${order.client?.lastname??''}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 13,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      width: double.infinity,
                      child: Text(
                        'Entregar en: ${order.address?.address??''}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 13,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
                    '${_con.users?.name} ${_con.users?.lastname}',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                    maxLines: 1,
                  ),
                  Text(
                    _con.users?.email,
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[300],
                        fontWeight: FontWeight.bold
                    ),
                    maxLines: 1,
                  ),
                  Text(
                    _con.users?.phone,
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


          _con.users != null ?
          _con.users.roles.length >1?

          ListTile(
            title: Text('Cambiar Rol'),
            trailing: Icon(Icons.person_outlined),
            onTap: _con.gotoRoles,

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
  void refresh() {
    setState(() {

    });
  }
}