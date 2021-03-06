

import 'package:delibery/src/models/biscategory.dart';
import 'package:delibery/src/pages/restaurant/create/reesurant_create_controller.dart';
import 'package:delibery/src/utils/my_colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter/scheduler.dart';


class RestaurantCreateePage extends StatefulWidget {
  const RestaurantCreateePage({Key key}): super(key: key);

  @override
  _RestaurantCreateePageState createState() => _RestaurantCreateePageState();
}

class _RestaurantCreateePageState extends State<RestaurantCreateePage> {
  RestaurantCreateController _con = new RestaurantCreateController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp){
      _con.init(context, refresh);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Negocio'),
      ),
      body: ListView(
        children: [
          Container(
              width: double.infinity,
              child:   SingleChildScrollView(
          child: Column(
          children: [
          SizedBox(height: 30),
          _ImgUser(),
          _TextName(),
          _TextLastName(),
            SizedBox(height: 30),

            _dropdowCategory(_con.categories),



          ],

    ),
    ),
          ),
        ],
      ),
      bottomNavigationBar:       _ButtonRegister()
      ,

    );

  }

   Widget _TextName(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.prymaryopacitycolor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.namecontroller,
        maxLength: 180,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(

            hintStyle: TextStyle(
              color: MyColors.prymaryColorDark,
            ),
            hintText: 'Nombre del Negocio  ',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            prefixIcon: Icon(
              Icons.person,
              color: MyColors.prymaryColor,
            )
        ),
      ),

    );

  }
  Widget _TextLastName(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.prymaryopacitycolor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        maxLines: 2,
        maxLength: 180,
        controller: _con.lastnamecontroller,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(

            hintStyle: TextStyle(
              color: MyColors.prymaryColorDark,
            ),
            hintText: 'Descripcion',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            prefixIcon: Icon(
              Icons.person_outline,
              color: MyColors.prymaryColor,
            )
        ),
      ),

    );

  }

  Widget _ButtonRegister(){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50,vertical: 20),
      child: ElevatedButton(
        onPressed: _con.isEnable ? _con.update:null,
        child: Text('Actualizar Restaurant'),
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
  Widget _ImgUser(){
    return GestureDetector(
      onTap: _con.showimgdialog,
      child: CircleAvatar(
        backgroundImage: _con.imagefile != null
            ? FileImage(_con.imagefile)
            :_con.user?.image != null ? NetworkImage(_con.user?.image ):
        AssetImage('assets/img/user_profile.png'),
        radius: 60,
        backgroundColor: Colors.grey[200],
      ),
    );
  }

  Widget _CircleRegister() {
    return Container(
      width: 240,
      height: 230,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: MyColors.prymaryColor
      ),

    );
  }

  Widget _dropdowCategory(List<Biscategories> categories){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 33,),
      child: Material(
        elevation: 2.0,
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                      Icons.search,
                      color: MyColors.prymaryColor,
                    ),
                  SizedBox(width: 15),
                  Text(
                      'Categorias de Negocio',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16
                    ),
                  ),





                ],
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButton(
                  underline: Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_drop_down_circle,
                      color: MyColors.prymaryColor,
                    ),
                  ),
                  elevation: 3,
                  isExpanded: true,
                  hint: Text('Seleciona una Categoria',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16
                  ),
                  ),
                  items: _droplist(categories),
                  value: _con.idCategory,
                  onChanged: (option){
                    setState(() {
                      _con.idCategory =option;//
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
  List<DropdownMenuItem<String>> _droplist(List<Biscategories> categories){
    List<DropdownMenuItem<String>> list = [];
    categories.forEach((items) {
      list.add(DropdownMenuItem(
        child: Text(items.name),
      value: items.id,
      ));
    });
    return list;
  }
  Widget _IconBack(){
    return IconButton(onPressed: _con.back, icon: Icon(Icons.arrow_back_ios,color:Colors.white)
    );
  }


  Widget _TextRegister() {
    return Text(
        'REGISTRAR',
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20
        )
    );
  }

  void refresh(){
    setState((){

    });
  }
}

