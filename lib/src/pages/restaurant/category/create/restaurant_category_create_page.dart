
import 'package:delibery/src/pages/restaurant/category/create/restaurant_category_create_controller.dart';
import 'package:delibery/src/utils/my_colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter/scheduler.dart';



class RestaurantCategoryCreatePage extends StatefulWidget {
  const RestaurantCategoryCreatePage({Key key}) : super(key: key);
  @override
  _RestaurantCategoryCreatePageState createState() => _RestaurantCategoryCreatePageState();
}

class _RestaurantCategoryCreatePageState extends State<RestaurantCategoryCreatePage> {

  RestauranrCategoryCreateControoler _con = new RestauranrCategoryCreateControoler();

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
        title: Text('Categorias'),
      ),
      body: Column(
        children: [
          SizedBox(height:30),
          _TextNewcate(),
          _TextNewcateDesc(),
        ],
      ),
      bottomNavigationBar: _ButtonCreate(),
    );
  }

  Widget _TextNewcate() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.prymaryopacitycolor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.namecontroller,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(

            hintStyle: TextStyle(
              color: MyColors.prymaryColorDark,
            ),
            hintText: 'Nombre de la Categoria',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            suffixIcon: Icon(
              Icons.list_alt,
              color: MyColors.prymaryColor,
            )
        ),
      ),

    );
  } Widget _TextNewcateDesc() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: MyColors.prymaryopacitycolor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.desccontroller,
        maxLines: 3,
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

  Widget _ButtonCreate(){
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50,vertical: 20),
      child: ElevatedButton(
        onPressed: _con.createCategory,
        child: Text('Crear Categoria'),
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