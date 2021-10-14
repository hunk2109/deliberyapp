import 'package:delivey/src/models/products.dart';
import 'package:delivey/src/utils/my_colors.dart';
import 'package:delivey/src/widgets/no_data_widgets.dart';
import 'package:flutter/material.dart';
import 'package:delivey/src/pages/client/orders/create/client_products_order_controller.dart';
import 'package:flutter/scheduler.dart';

class ClientOrdersCreatePge extends StatefulWidget {

  const  ClientOrdersCreatePge({Key key}): super(key: key);
  @override
  _ClientOrdersCreatePgeState createState() => _ClientOrdersCreatePgeState();
}

class _ClientOrdersCreatePgeState extends State<ClientOrdersCreatePge> {
  ClientProductsOrdersCreateController _con = ClientProductsOrdersCreateController();
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
        title: Text('Mi Orden'),
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height*0.268,
        child: Column(
          children: [
            Divider(color: Colors.grey[400],
              endIndent: 30,// margen derecha
              indent: 30,// margen isquierda
            ),
            _textTotalPrice(),
            _BottonConfirm(),
          ],
        ),
      ),
      body: _con.seletedPrducts.length >0
          ? ListView(
        children: _con.seletedPrducts.map((Products products) {
          return _carProducts(products);
        }
        ).toList(),
      ):NodataWidget(text:'Ningun Producto en la Bolsa')
      ,);
  }

  Widget _BottonConfirm(){
    return Container(
        margin: EdgeInsets.only(left: 30,right: 30,top: 30,bottom: 30),
        child: ElevatedButton(
          onPressed:(){_con.gotoddres();},
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
                  height: 50,
                  child: Text(
                      'Confirmar',
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
                  margin: EdgeInsets.only(left: 70,top: 7),
                  height: 30,
                  child: Icon(Icons.check_circle,
                      color: Colors.green,
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
            width: 90,
            height: 90,
            padding: EdgeInsets.all(10),
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
              _addorRemove(products),





            ],
          ),
          Spacer(),
          Column(
            children: [
              _addremovpiece(products),
              _iconDelete(products),

            ],
          ),

        ],
      ),
    );
  }
  Widget _iconDelete(Products products){
    return IconButton(
      onPressed:(){_con.deleteitems(products);},
      icon: Icon(Icons.delete,
        color: MyColors.prymaryColor,),
    );
  }
  Widget _addremovpiece(Products products){
    return Container(
      margin: EdgeInsets.only(top:10),
      child: Text(
        '${products.price*products.quantity}',
        style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold
        ),
      ),
    )   ;
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
  Widget _addorRemove(Products products){
    return   Row(
      children: [
        GestureDetector(
          onTap: (){_con.removitems(products);},
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 7),
            decoration:  BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),


                ),
                color: Colors.grey[200]


            ),
            child: Text('-'),

          ),
        ),
        Container(
          color: Colors.grey[200],
          child: Text('${products?.quantity?? 0}'),
          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 7),

        ),
        GestureDetector(
          onTap: (){_con.additems(products);},
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 7),
            decoration:  BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),


                ),
                color: Colors.grey[200]


            ),
            child: Text('+'),

          ),
        ),

      ],
    );
  }
  void refresh(){
    setState(() {

    });
  }
}