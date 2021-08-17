import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:delivey/src/models/user.dart';
import 'package:delivey/src/provider/user_provider.dart';
import 'package:delivey/src/models/response_api.dart';
import 'package:delivey/src/utils/mysnackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RegisterController{

  BuildContext context;
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController lastnamecontroller = new TextEditingController();
  TextEditingController phonecontroller = new TextEditingController();
  TextEditingController passcontroller = new TextEditingController();
  TextEditingController checkpasscontroller = new TextEditingController();
  UserProvider usersProvider = new UserProvider();
  PickedFile pickedFile;
  File imagefile;
  Function refresh;



  Future init(BuildContext context, Function refresh){
    this.context = context;
    usersProvider.init(context);
    this.refresh = refresh;
  }

  void register()async {
    String email = emailcontroller.text.trim();
    String name =  namecontroller.text;
    String lastname = lastnamecontroller.text;
    String phone = phonecontroller.text.trim();
    String pass = passcontroller.text.trim();
    String checkpass = checkpasscontroller.text.trim();

    if(email.isEmpty||name.isEmpty||lastname.isEmpty||phone.isEmpty||pass.isEmpty||checkpass.isEmpty){

      MySnackbar.show(context, 'Ingresa todos los campos');

      return;
    }

    if(checkpass !=  pass){
      MySnackbar.show(context, 'Contraseña y Confirmar no coinciden');
      return;

    }

    if(pass.length<6){
      MySnackbar.show(context, 'La Contraseña debe ser mas larga ');
      return;
    }


    if(imagefile == null){
      MySnackbar.show(context, 'Selecciona una Imagen ');
      return;
    }

    Users user= new Users(

      email: email,
      name: name,
      lastname: lastname,
      phone: phone,
      password:pass,

    );

    Stream stream = await usersProvider.createWithimg(user, imagefile);
    stream.listen((res) {
      //ResponseApi responseApi = await usersProvider.create(user);
      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      print('Respuesta: ${responseApi.toJson()}');

      MySnackbar.show(context, responseApi.message);



      if(responseApi.succes = true){
        Future.delayed(Duration(seconds: 3),(){
          Navigator.pushReplacementNamed(context, 'login');
        });
      }

    });


   /* print(email);
    print(name);
    print(lastname);
    print(phone);
    print(pass);
    print(checkpass);*/
  }

  Future selectimg(ImageSource imageSource) async{

    pickedFile = await ImagePicker().getImage(source: imageSource);
    if(pickedFile != null){
      imagefile = File(pickedFile.path);
    }
    Navigator.pop(context);
    refresh();
  }
void showimgdialog(){
    Widget cameraButton = ElevatedButton(
        onPressed: (){selectimg(ImageSource.gallery);}, child: Text('Galeria')
    );Widget galleyButton = ElevatedButton(
        onPressed: (){selectimg(ImageSource.camera);}, child: Text('Camara')
    );
    AlertDialog  alertDialog  = AlertDialog(
        title: Text('Selecciona una Imagen'),
        actions: [
          cameraButton,
          galleyButton,
  ],
  );

    showDialog(
      context: context,
      builder: (BuildContext context){
        return alertDialog;
      }

    );

}

  void back(){
    Navigator.pop(context);
  }
}