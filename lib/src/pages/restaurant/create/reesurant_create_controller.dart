import 'dart:convert';

import 'package:delivery/src/models/biscategory.dart';
import 'package:delivery/src/models/response_api.dart';
import 'package:delivery/src/models/restaurant.dart';
import 'package:delivery/src/models/user.dart';
import 'package:delivery/src/provider/biscategory_provider.dart';
import 'package:delivery/src/provider/restaurant_provider.dart';
import 'package:delivery/src/provider/user_provider.dart';
import 'package:delivery/src/utils/mysnackbar.dart';
import 'package:delivery/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';


class RestaurantCreateController{

  BuildContext context;

  TextEditingController namecontroller = new TextEditingController();
  TextEditingController lastnamecontroller = new TextEditingController();
  TextEditingController phonecontroller = new TextEditingController();
  RestaurantsProvider _restaurantsProvider =RestaurantsProvider();
  UserProvider usersProvider = new UserProvider();
  PickedFile pickedFile;
  File imagefile;
  Function refresh;
  ProgressDialog _progressDialogl;
  bool isEnable = true;
  Users user;
  SharedPref _sharedPref = new SharedPref();
  BiscategoriesPorvider biscategoriesPorvider = BiscategoriesPorvider();
  List<Biscategories> categories = [];
  String idCategory;






  Future init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    _progressDialogl = ProgressDialog(context: context);
    user = Users.fromJson(await _sharedPref.read('user'));
    usersProvider.init(context, sessionuser: user);
    _restaurantsProvider.init(context,user);
    biscategoriesPorvider.init(context, user);
    getCategoriesBis();
    refresh();



    /*namecontroller.text = user.name;
    lastnamecontroller.text = user.lastname;
    phonecontroller.text =  user.phone;*/



  }

  void getCategoriesBis() async{
    categories = await biscategoriesPorvider.getallbis();
    refresh();

  }
  void update()async {

    String name =  namecontroller.text;
    String desc = lastnamecontroller.text;
    String phone = phonecontroller.text.trim();


    if(name.isEmpty||desc.isEmpty){

      MySnackbar.show(context, 'Ingresa todos los campos');

      return;
    }




    if(imagefile == null){
      MySnackbar.show(context, 'Selecciona una Imagen ');
      return;
    }

    if(idCategory == null){
      MySnackbar.show(context, 'Selecciona una Categoria');
      return;
    }

    Restaurant restaurant = new  Restaurant(


      name: name,
      description: desc,
      //image1: 'Prueba1,',
      idUser: user.id,
      idCategory:idCategory,



    );

    print('${restaurant.toJson()}');

    List<File> images = [];
    images.add(imagefile);
    _progressDialogl.show(max: 100, msg:'Espera un momento');
    Stream stream  = await _restaurantsProvider.create(restaurant,imagefile);
    stream.listen((res) {
      _progressDialogl.close();
      ResponseApi responseApi = new ResponseApi.fromJson(json.decode(res));
      MySnackbar.show(context, responseApi.message);
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