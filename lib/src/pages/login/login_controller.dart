
import 'package:delibery/src/models/response_api.dart';
import 'package:delibery/src/models/user.dart';
import 'package:delibery/src/provider/push_notification_provider.dart';
import 'package:delibery/src/provider/user_provider.dart';
import 'package:delibery/src/utils/mysnackbar.dart';
import 'package:delibery/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';



class LoginController{
  BuildContext context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  UserProvider userProvider = new UserProvider();
  SharedPref _sharedPref = new SharedPref();
  PushNotificationProvider pushNotificationProvider = PushNotificationProvider();


  Future init(BuildContext context) async {
    this.context = context;
    await  userProvider.init(context);
    Users users = Users.fromJson(await _sharedPref.read('user')?? {});

    if(users?.sessionToken!= null){
      pushNotificationProvider.saveToken(users,context);

      if(users.roles.length >1){
        Navigator.pushNamedAndRemoveUntil(context,'roles', (route) => false);


      }
      else{
        Navigator.pushNamedAndRemoveUntil(context, users.roles[0].route, (route) => false);

      }
    }





  }
  void goToRegisterPage(){
    Navigator.pushNamed(context, 'register');

  }
  void login() async{
    String email = emailController.text.trim();
    String password = passController.text.trim();
    ResponseApi responseApi = await userProvider.login(email, password);
    print('Respuesta object: ${responseApi}');
    print('Respuesta: ${responseApi.toJson()}');


    try{

      if(responseApi.succes = true ){
        Users user= Users.fromJson(responseApi.data);
        _sharedPref.save('user', user.toJson());
        pushNotificationProvider.saveToken(user,context);

       print('LOG: ${user.toJson()}');
        if(user.roles.length >1){
          Navigator.pushNamedAndRemoveUntil(context,'roles', (route) => false);


        }
        else{
          Navigator.pushNamedAndRemoveUntil(context, user.roles[0].route, (route) => false);

        }

      }


    }

    catch(e){

      MySnackbar.show(context, responseApi.message);

    }







    /*print('Email: $email');
    print('Pass: $pass' );*/
  }
}