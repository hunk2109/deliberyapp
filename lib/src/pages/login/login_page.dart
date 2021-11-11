import 'package:delivery/src/pages/login/login_controller.dart';
import 'package:delivery/src/utils/my_colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter/scheduler.dart';
class Loginpage extends StatefulWidget {

  const Loginpage({Key key}) : super(key: key);

  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {

  LoginController _con = new LoginController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Init');
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      print('Schedular Inti');
      _con.init(context);
    });



  }

  @override
  Widget build(BuildContext context) {
    print('Secont');

    return Scaffold(

      body: Container(
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                  top: -80,
                  left: -100,

                  child:
                  _Circlelogin()),
              Positioned(
                child: _Textlogin(),
                top: 60,
                left: 25,

              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    _ImageBaner(),
                    _Textimail(),
                    _TextPass(),
                    _ButtonLogin(),
                    _TextnoAcount(),
                  ],
                ),
              ),
            ],
          )
      ),

    );
  }

  Widget _ImageBaner(){
    return
      Container(margin: EdgeInsets.only(
          top:110,
          bottom:MediaQuery.of(context).size.height*0.03),
        child: Image.asset(
          'assets/img/logodelifast.png',
          width: 300,
          height: 300,
        ),
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
        controller: _con.emailController,
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

  }

  Widget _TextPass(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.prymaryopacitycolor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.passController,
        obscureText:true,
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

  Widget _ButtonLogin(){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50,vertical: 20),
      child: ElevatedButton(
        onPressed: _con.login,
        child: Text('Ingresar'),
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
  Widget _TextnoAcount(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            'No tienes Cuenta?',
            style: TextStyle(
                color: MyColors.prymaryColor
            )

        ),

        SizedBox(width: 7,),
        GestureDetector(
          onTap:_con.goToRegisterPage,
          child: Text(
            'Registrate!',
            style: TextStyle(
                fontWeight:FontWeight.bold,
                color: MyColors.prymaryColor


            ),
          ),
        )
      ],
    );


  }


}
Widget _Circlelogin(){
  return Container(
    width: 240,
    height: 230,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color:MyColors.prymaryColor
    ),

  );


}

Widget _Textlogin(){
  return Text(
      'LOGIN',
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 22
      )
  );
}