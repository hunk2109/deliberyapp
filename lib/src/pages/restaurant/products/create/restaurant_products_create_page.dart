

import 'package:delibery/src/models/categories.dart';
import 'package:delibery/src/pages/restaurant/products/create/restaurant_products_create_cotroller.dart';
import 'package:delibery/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:io';



class RestaurantProductsCreatePage extends StatefulWidget {
  const RestaurantProductsCreatePage({Key key}) : super(key: key);
  @override
  _RestaurantProductsCreatePageState createState() => _RestaurantProductsCreatePageState();
}

class _RestaurantProductsCreatePageState extends State<RestaurantProductsCreatePage> {

  RestauranrProductsCreateController _con = new RestauranrProductsCreateController();

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
        title: Text('Agregar Productos'),
      ),
      body: ListView(
        children: [
          SizedBox(height:30),
          _TextNewcate(),
          _TextNewcateDesc(),
          _TextNewprodprice(),
          Container(
            height: 100,
            margin: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _cardImage(_con.imagefile1, 1),
                _cardImage(_con.imagefile2, 2),
                _cardImage(_con.imagefile3, 3),

              ],
            ),
          ),
          _dropDowmCategories(_con.category)
        ],
      ),
      bottomNavigationBar: _ButtonCreate(),
    );
  }

  Widget _TextNewcate() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.prymaryopacitycolor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.namecontroller,
        maxLines: 1,
        maxLength: 180,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(

            hintStyle: TextStyle(
              color: MyColors.prymaryColorDark,
            ),
            hintText: 'Nombre del Producto',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            suffixIcon: Icon(
              Icons.local_pizza,
              color: MyColors.prymaryColor,
            )
        ),
      ),

    );
  } Widget _TextNewcateDesc() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: MyColors.prymaryopacitycolor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.desccontroller,
        maxLines: 2,
        maxLength: 255,

        keyboardType: TextInputType.name,
        decoration: InputDecoration(

            hintStyle: TextStyle(
              color: MyColors.prymaryColorDark,
            ),
            hintText: 'Descripcion de la Categoria',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            suffixIcon: Icon(
              Icons.description,
              color: MyColors.prymaryColor,
            )
        ),
      ),

    );
  }

  Widget _TextNewprodprice() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: MyColors.prymaryopacitycolor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.pricecontroller,
        maxLines:1,

        keyboardType: TextInputType.phone,
        decoration: InputDecoration(

            hintStyle: TextStyle(
              color: MyColors.prymaryColorDark,
            ),
            hintText: 'Precio',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            suffixIcon: Icon(
              Icons.monetization_on,
              color: MyColors.prymaryColor,
            )
        ),
      ),

    );
  }

  Widget _cardImage(File imageFile, int numberFile ){
    return GestureDetector(
      onTap:(){_con.showimgdialog(numberFile);
      },
      child: imageFile != null ?
      Card(
        elevation: 3.0,
        child: Container(
            height: 140,
            width: MediaQuery.of(context).size.width*0.26,
            child: Image.file(
              imageFile,
              fit: BoxFit.cover,
            )
        ),
      )
          :
      Card(
        elevation: 3.0,
        child: Container(
            height: 140,
            width: MediaQuery.of(context).size.width*0.26,
            child: Image(
              image: AssetImage('assets/img/add_image.png'),
              fit: BoxFit.cover,
            )
        ),
      ),
    );
  }

  Widget _dropDowmCategories(List<Category> categories){

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 33),
      child: Material(
        elevation: 2.0,
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Material(
                    elevation: 0,
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: Icon(
                      Icons.search,
                      color: MyColors.prymaryColor,
                    ),

                  ),
                  SizedBox(width: 15,),
                  Text('Categorias',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      )
                  )
                ],
              ),
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
                    'Selecciona una Categoria',
                    style: TextStyle(color: Colors.grey,
                      fontSize: 16,),

                  ),
                  items: _dropDownItem(categories),
                  value: _con.idCat,
                  onChanged: (options){
                    setState((){
                      _con.idCat = options;
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
  List<DropdownMenuItem<String>>_dropDownItem(List<Category>categories){
    List<DropdownMenuItem<String>> list = [];
    categories.forEach((category) {
      list.add(DropdownMenuItem(
        child: Text(category.name),
        value: category.id,
      ));
    });

    return list;
  }
  Widget _ButtonCreate(){
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50,vertical: 20),
      child: ElevatedButton(
        onPressed: _con.createProducts,
        child: Text('Crear Producto'),
        style: ElevatedButton.styleFrom(
            primary: MyColors.prymaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
            ),
            padding: EdgeInsets.symmetric(vertical: 15)
        ),
      ),
    );
  }

  void refresh(){
    setState((){});
  }
}