import 'package:delivery/src/models/orders.dart';
import 'package:delivery/src/models/products.dart';
import 'package:delivery/src/pages/delibery/orders/details/delibery_products_details_controller.dart';
import 'package:delivery/src/utils/relative_time_util.dart';
import 'package:delivery/src/widgets/no_data_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


class DeliberytOrdersDetailsPage extends StatefulWidget {
  Order order;

  DeliberytOrdersDetailsPage({Key key, @required this.order}): super(key: key);
  @override
  _DeliberytOrdersDetailsPageState createState() => _DeliberytOrdersDetailsPageState();
}

class _DeliberytOrdersDetailsPageState extends State<DeliberytOrdersDetailsPage>
{
  DeliberyOrdersDetailsController _con =   DeliberyOrdersDetailsController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh,widget.order);

    });
  }


  @override



  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orden # ${_con.order?.id ??''}'),
        actions: [
          Container(
            margin: EdgeInsets.only(top:13, right: 15),
            child: Text('Total: ${_con.total}\$',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height*0.4,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Divider(color: Colors.grey[400],
                endIndent: 30,// margen derecha
                indent: 30,// margen isquierda
              ),


              _textClient('Cliente: ','${_con.order.client?.name??''} ${_con.order.client?.lastname??''}' ),
              _textClient('Entregar en: ','${_con.order.address?.address ??''}'),
              _textClient('Fecha del Pedido: ',

                  '${RelativeTimeUtil.getRelativeTime(_con.order.timestamp??'')}'  ),
              // _textTotalPrice(),
              _con.order.status !='ENTREGADO' ? _BottonConfirm():Container(),
            ],
          ),
        ),
      ),
      body: _con.order.products.length >0
          ? ListView(
        children: _con.order.products.map((Products products) {
          return _carProducts(products);
        }
        ).toList(),
      ):NodataWidget(text:'Ningun Producto en la Bolsa')
      ,);
  }



  Widget _textClient(String title,String conten){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20,),
      child: ListTile(
        title: Text(title),
        subtitle:Text(conten,
          maxLines: 2,) ,
      ),
    );
  }

  Widget _BottonConfirm(){
    return Container(
        margin: EdgeInsets.only(left: 30,right: 30,top: 5,bottom: 5),
        child: ElevatedButton(
          onPressed:_con.updateOrder,
          style: ElevatedButton.styleFrom(
              primary: _con.order?.status == 'LISTO' ? Colors.blue:
              Colors.green,
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
                      _con.order?.status == 'LISTO' ? 'Iniciar Entrega':
                      'Ir al Mapa',
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
                  child: Icon(Icons.directions_bike_outlined,
                      color: Colors.white,
                      size: 30),
                ),
              ),



            ],
          ),
        )
    );
  }
  Widget _carProducts(Products products){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color:Colors.grey[200]
            ),
            child:FadeInImage(
              image: products.image1 != null
                  ?NetworkImage(products.image1):

              AssetImage('assets/img/no-image.png'),
              fit: BoxFit.contain,
              fadeInDuration: Duration(milliseconds: 50),
              placeholder:AssetImage('assets/img/no-image.png'),
            ),
          ),
          SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(products.name?? '',
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10,),
              Text('Cantidad: ${products?.quantity?? ''}',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),





            ],
          ),


        ],
      ),
    );
  }


  Widget _textTotalPrice(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Total:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,

            ),
          ),
          Text('${_con.total}\$',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  void refresh(){
    setState(() {

    });
  }
}