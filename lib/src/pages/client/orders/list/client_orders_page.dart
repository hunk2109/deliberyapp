
import 'package:delivery/src/models/orders.dart';
import 'package:delivery/src/pages/client/orders/list/client_orders_list_controller.dart';
import 'package:delivery/src/utils/my_colors.dart';
import 'package:delivery/src/utils/relative_time_util.dart';
import 'package:delivery/src/widgets/no_data_widgets.dart';
import 'package:flutter/material.dart';

import 'package:flutter/scheduler.dart';


class ClientOrdersListPage extends StatefulWidget {

  const ClientOrdersListPage ({Key key}) : super(key: key);

  @override
  _ClientOrdersListPageState createState() => _ClientOrdersListPageState();


}

class _ClientOrdersListPageState  extends State<ClientOrdersListPage> {

  ClientOrdersListController _con = new ClientOrdersListController();

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
                title: Text('Mis Pedidos'),

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
                backgroundColor: MyColors.prymaryColor ,

              )
          ),
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
                        'Repartidor: ${order.delibery?.name??'No asignado'} ${order.delibery?.lastname??''}',
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





  void refresh() {
    setState(() {

    });
  }
}