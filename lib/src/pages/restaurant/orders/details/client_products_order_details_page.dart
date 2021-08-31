import 'package:delivey/src/models/orders.dart';
import 'package:delivey/src/models/products.dart';
import 'package:delivey/src/models/user.dart';
import 'package:delivey/src/pages/restaurant/orders/details/client_products_details_controller.dart';
import 'package:delivey/src/utils/my_colors.dart';
import 'package:delivey/src/widgets/no_data_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class RestaurantOrdersDetailsPage extends StatefulWidget {
  Order order;

   RestaurantOrdersDetailsPage({Key key, @required this.order}): super(key: key);
  @override
  _RestaurantOrdersDetailsPageState createState() => _RestaurantOrdersDetailsPageState();
}

class _RestaurantOrdersDetailsPageState extends State<RestaurantOrdersDetailsPage>
{
  RestaurantOrdersDetailsController _con =  RestaurantOrdersDetailsController();
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
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height*0.4,
        child: Column(
          children: [
            Divider(color: Colors.grey[400],
              endIndent: 30,// margen derecha
              indent: 30,// margen isquierda
            ),
            _dropDowmCategories([]),
            _textClient('Cliente: ','${_con.order.client?.name??''} ${_con.order.client?.lastname??''}' ),
            SizedBox(height: 8,),
            _textClient('Entregar en: ','${_con.order.address?.address ??''}'),
            SizedBox(height: 8,),
            _textClient('Fecha del Pedido: ','${_con.order.timestamp??''}'  ),
            _textTotalPrice(),
            _BottonConfirm(),
          ],
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

  Widget _dropDowmCategories(List<Users> users){

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Material(
        elevation: 2.0,
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: Container(
          padding: EdgeInsets.all(0),
          child: Column(
            children: [

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButton(
                  underline:Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                        Icons.arrow_drop_down_circle,
                        color: MyColors.prymaryColor
                    ),
                  ),
                  elevation: 3,
                  isExpanded: true,
                  hint: Text(
                    'Reparidor',
                    style: TextStyle(color: Colors.grey,
                      fontSize: 16,),

                  ),
                  items: _dropDownItem(users),
                  //value: _con.idCat,
                  onChanged: (options){
                    setState((){
                     // _con.idCat = options;
                    });
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );

  }

  List<DropdownMenuItem<String>>_dropDownItem(List<Users>users){
    List<DropdownMenuItem<String>> list = [];
    users.forEach((users) {
      list.add(DropdownMenuItem(
        child: Text(users.name),
        value: users.id,
      ));
    });

    return list;
  }
  Widget _textClient(String title,String conten){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            maxLines: 2,
          ),
          SizedBox(),
          Text(
            conten,

          )
        ],
      ) ,
    );
  }

  Widget _BottonConfirm(){
    return Container(
        margin: EdgeInsets.only(left: 30,right: 30,top: 10,bottom: 10),
        child: ElevatedButton(
          onPressed:(){},
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
                      'Despachar Orden',
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
              Text('Cantidad: ${products?.quantity?? ''}',
                style: TextStyle(
                    fontWeight: FontWeight.bold
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
