import 'package:delivey/src/models/products.dart';
import 'package:delivey/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:delivey/src/pages/client/produts/details/client_producst_details_controller.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class ClientProdctsDetailsPages extends StatefulWidget {
  Products products;
    ClientProdctsDetailsPages({Key key, @required this.products}): super(key: key);
  @override
  _ClientProdctsDetailsPagesState createState() => _ClientProdctsDetailsPagesState();
}

class _ClientProdctsDetailsPagesState extends State<ClientProdctsDetailsPages> {
  ClientProductsDetailsController _con = ClientProductsDetailsController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh,widget.products);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height *0.9,
      child: Column(
        children: [
          _imageSlider(),
          _SliderText(),
          _TextDescSilder(),
          Spacer(),
          _addorRemoveItems(),
          sendDelibery(),
          _BottonAdd(),

        ],
      ),
    );
  }

  Widget _SliderText(){
    return Container(
      margin: EdgeInsets.only(right: 30,left: 30,top: 30),
      alignment: Alignment.centerLeft,
      child: Text(
        _con.products?.name ?? '',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,


        ),
      ),
    );

  }
  Widget _addorRemoveItems(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Row(

        children: [

          IconButton(onPressed: _con.additemc,
              icon: Icon(Icons.add_circle_outline,
                color: Colors.grey,
                size: 30,

              ),

          ),
          Text('${_con.counter}',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.grey
          ),
          ),
          IconButton(onPressed: _con.removitemc,
            icon: Icon(Icons.remove_circle_outline,
              color: Colors.grey,
              size: 30,
            ),

          ),

          Spacer(),
          Container(
            margin: EdgeInsets.only(right: 10),
            child:  Text('${_con?.productprice ??0}\$',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,

              ),
            ),
          ),



        ],

      ),
    );
  }
  Widget sendDelibery(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
      child:  Row(
        children: [
          Image.asset('assets/img/delivery.png',
          height: 17,

          ),
          SizedBox(width: 7,),
          Text(
            'Envio Estandar',
            style:  TextStyle(
              fontSize: 12,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _BottonAdd(){
    return Container(
      margin: EdgeInsets.only(left: 30,right: 30,top: 30,bottom: 30),
      child: ElevatedButton(
        onPressed: _con.addToBag,
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
                  'Agregar a la Bolsa',
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
                margin: EdgeInsets.only(left: 50,top: 7),
                height: 30,
                child: Image.asset('assets/img/bag.png',
                ),
              ),


            )
          ],
        ),
      )
    );
  }
  Widget _TextDescSilder(){
    return Container(
      margin: EdgeInsets.only(right: 30,left: 30,top: 15),
      alignment: Alignment.centerLeft,
      child: Text(
        _con.products?.description ?? '',
        style: TextStyle(
          fontSize: 13,
          color: Colors.grey[250],

        ),
      ),
    );
  }

  Widget _imageSlider(){

    return Stack(
      children: [
        ImageSlideshow(
          width: double.infinity,
          height: MediaQuery.of(context).size.height *0.4,
          initialPage: 0,
          indicatorColor: Colors.blue,
          indicatorBackgroundColor: Colors.grey,
          onPageChanged: (value) {
            debugPrint('Page changed: $value');
          },
          autoPlayInterval: 15000,
          isLoop: true,
          children: [
            FadeInImage(
              image: _con.products?.image1 != null
                  ?NetworkImage(_con.products.image1):

              AssetImage('assets/img/no-image.png'),
              fit: BoxFit.cover,
              fadeInDuration: Duration(milliseconds: 50),
              placeholder:AssetImage('assets/img/no-image.png'),
            ),
            FadeInImage(
              image: _con.products?.image2 != null
                  ?NetworkImage(_con.products.image2):

              AssetImage('assets/img/no-image.png'),
              fit: BoxFit.cover,
              fadeInDuration: Duration(milliseconds: 50),
              placeholder:AssetImage('assets/img/no-image.png'),
            ),
            FadeInImage(
              image: _con.products?.image3 != null
                  ?NetworkImage(_con.products.image3):

              AssetImage('assets/img/no-image.png'),
              fit: BoxFit.cover,
              fadeInDuration: Duration(milliseconds: 50),
              placeholder:AssetImage('assets/img/no-image.png'),
            ),
          ],
        ),

        Positioned(
          left: 20,
            child: IconButton(
          onPressed: _con.close,
          icon: Icon(Icons.arrow_back_ios, color: MyColors.prymaryColor),
        )
        )
      ],
    );

  }
  void refresh(){
    setState(() {

    });
  }
}
