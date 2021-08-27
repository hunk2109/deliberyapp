import 'dart:convert';
import 'package:delivey/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:delivey/src/models/user.dart';
import 'package:delivey/src/provider/user_provider.dart';
import 'package:delivey/src/models/response_api.dart';
import 'package:delivey/src/utils/mysnackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateController{

  BuildContext context;

  TextEditingController namecontroller = new TextEditingController();
  TextEditingController lastnamecontroller = new TextEditingController();
  TextEditingController phonecontroller = new TextEditingController();

  UserProvider usersProvider = new UserProvider();
  PickedFile pickedFile;
  File imagefile;
  Function refresh;
  ProgressDialog _progressDialogl;
  bool isEnable = true;
  Users user;
  SharedPref _sharedPref = new SharedPref();





  Future init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    _progressDialogl = ProgressDialog(context: context);
    user = Users.fromJson(await _sharedPref.read('user'));
    usersProvider.init(context,token:user.sessionToken);


    namecontroller.text = 'Hola';//user.name;
    lastnamecontroller.text = user.lastname;
    phonecontroller.text = user.phone;
    refresh();


  }

  void update()async {

    String name =  namecontroller.text;
    String lastname = lastnamecontroller.text;
    String phone = phonecontroller.text.trim();


    if(name.isEmpty||lastname.isEmpty||phone.isEmpty){

      MySnackbar.show(context, 'Ingresa todos los campos');

      return;
    }




    if(imagefile == null){
      MySnackbar.show(context, 'Selecciona una Imagen ');
      return;
    }

    Users  Myuser= new Users(


      id: user.id,
      name: name,
      lastname: lastname,
      phone: phone,
      image: user.image,


    );

    Stream stream = await usersProvider.update(Myuser, imagefile);
    stream.listen((res) async {
      _progressDialogl.close();
      //ResponseApi responseApi = await usersProvider.create(user);
      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      print('Respuesta: ${responseApi.toJson()}');

      //MySnackbar.show(context, responseApi.message);



      if(responseApi.succes = true){
        user = await usersProvider.getByid(Myuser.id);
        _sharedPref.save('user', user.toJson());
        Fluttertoast.showToast(msg: responseApi.message);
        Future.delayed(Duration(seconds: 3),(){
          Navigator.pushNamedAndRemoveUntil(context, 'client/produts/list', (route) => false);
        });
      }

      else{
        isEnable = true;
      }


      _progressDialogl.show(max: 100, msg: 'Casi listo');
      isEnable = false;
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