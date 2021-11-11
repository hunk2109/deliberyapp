
import 'package:delivery/src/pages/client/update/client_update_controller.dart';
import 'package:delivery/src/utils/my_colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter/scheduler.dart';


class ClientUpdatePage extends StatefulWidget {
  const ClientUpdatePage({Key key}): super(key: key);

  @override
  _ClientUpdatePageState createState() => _ClientUpdatePageState();
}

class _ClientUpdatePageState extends State<ClientUpdatePage> {
  UpdateController _con = new UpdateController();
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
        title: Text('Editar Perfil'),
      ),
      body: Container(
        width: double.infinity,
        child:   SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),
              _ImgUser(),
              _TextName(),
              _TextLastName(),
              _TextPhone(),



            ],

          ),
        ),
      ),
      bottomNavigationBar:       _ButtonRegister()
      ,

    );

  }

  Widget _Textimail(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.prymaryopacitycolor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(

        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(

            hintStyle: TextStyle(
              color: MyColors.prymaryColorDark,
            ),
            hintText: 'Correo Electronico',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            prefixIcon: Icon(
              Icons.email,
              color: MyColors.prymaryColor,
            )
        ),
      ),

    );

  } Widget _TextName(){
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
            hintText: 'Nombre',
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
        controller: _con.lastnamecontroller,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(

            hintStyle: TextStyle(
              color: MyColors.prymaryColorDark,
            ),
            hintText: 'Apellido',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            prefixIcon: Icon(
              Icons.person_outline,
              color: MyColors.prymaryColor,
            )
        ),
      ),

    );

  }Widget _TextPhone(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.prymaryopacitycolor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.phonecontroller,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(

            hintStyle: TextStyle(
              color: MyColors.prymaryColorDark,
            ),
            hintText: 'Telefono',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            prefixIcon: Icon(
              Icons.phone,
              color: MyColors.prymaryColor,
            )
        ),
      ),

    );

  }
  Widget _TextChetPass(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.prymaryopacitycolor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(

        obscureText: true,
        decoration: InputDecoration(

            hintStyle: TextStyle(
              color: MyColors.prymaryColorDark,
            ),
            hintText: 'Confirmar Contraseña',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            prefixIcon: Icon(
              Icons.lock_clock_outlined,
              color: MyColors.prymaryColor,
            )
        ),
      ),

    );

  }
  Widget _TextPass(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.prymaryopacitycolor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(

        obscureText: true,
        decoration: InputDecoration(

            hintStyle: TextStyle(
              color: MyColors.prymaryColorDark,
            ),
            hintText: 'Contraseña',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            prefixIcon: Icon(
              Icons.lock,
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
        child: Text('Actualizar Perfil'),
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

  Widget _IconBack(){
    return IconButton(onPressed: _con.back, icon: Icon(Icons.arrow_back_ios,color:Colors.white)
    );
  }


  Widget _TextRegister() {
    return Text(
        'REGISTRO',
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