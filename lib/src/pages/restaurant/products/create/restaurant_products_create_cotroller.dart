import 'dart:convert';
import 'dart:io';

import 'package:delivery/src/models/categories.dart';
import 'package:delivery/src/models/products.dart';
import 'package:delivery/src/models/response_api.dart';
import 'package:delivery/src/models/user.dart';
import 'package:delivery/src/provider/categories_provider.dart';
import 'package:delivery/src/provider/products_provider.dart';
import 'package:delivery/src/utils/mysnackbar.dart';
import 'package:delivery/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';

import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:core';

import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class RestauranrProductsCreateController{

  List<Category> category = [];
  String idCat; // id de la categoria
  BuildContext context;
  Function refresh;
  SharedPref _sharedPref = new SharedPref();

  TextEditingController namecontroller =new TextEditingController();
  TextEditingController desccontroller = new TextEditingController();
  MoneyMaskedTextController pricecontroller = MoneyMaskedTextController();

  CategoriesProvider _categoriesProvider = new CategoriesProvider();
  ProductsProvider _productsProvider = ProductsProvider();
  Users user;
  String idRes;



  //imagenes
  PickedFile pickedFile;
  File imagefile1;
  File imagefile2;
  File imagefile3;
  ProgressDialog _progressDialog;


  Future init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    _progressDialog = new ProgressDialog(context: context);
    user = Users.fromJson(await _sharedPref.read('user'));
    _categoriesProvider.init(context, user);
    _productsProvider.init(context, user);
    getCategory();
  }

  void getCategory() async {
    category = await _categoriesProvider.getall();
    refresh();
  }
  void createProducts() async {
    String name = namecontroller.text;
    String description = desccontroller.text;
    double price = pricecontroller.numberValue;

    if (name.isEmpty || description.isEmpty || price == 0 ){
      MySnackbar.show(context, 'Debes llenar todos lo campos');
      return;
    }

    if(imagefile1 == null ||imagefile2 == null ||imagefile3 == null ){

      MySnackbar.show(context, 'Debes seleccionar imagenes');
      return;
    }

    if(idCat == null){
      MySnackbar.show(context, 'Debes seleccionar una categoria');
      return;
    }




    idRes = user.idRestaurant;
    Products products = new Products(
      name: name,
      description: description,
      price: price,
      idCategory: int.parse(idCat),
      idRestaurant: int.parse(user.idRestaurant),



    );

    print('valor: ${products.toJson()}');

    List<File> images = [];
    images.add(imagefile1);
    images.add(imagefile2);
    images.add(imagefile3);
    _progressDialog.show(max: 100, msg: 'Ya casi');
    Stream  stream = await _productsProvider.create(products, images);
    stream.listen((res) {
            _progressDialog.close();
            ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
            MySnackbar.show(context, responseApi.message);

            if(responseApi.succes = true){
              resetValues();
            }
    });
    print('Products: ${products.toJson()}');
  }

  void resetValues(){
    namecontroller.text ='';
    desccontroller.text = '';
    pricecontroller.text = '0.00';
    imagefile1 = null;
    imagefile2 = null;
    imagefile3 = null;
    idCat = null;
    refresh();
  }
  Future selectimg(ImageSource imageSource,int numberfile) async{

    pickedFile = await ImagePicker().getImage(source: imageSource);
    if(pickedFile != null){

      if(numberfile == 1){

        imagefile1 = File(pickedFile.path);

      }
     else if(numberfile == 2){

        imagefile2 = File(pickedFile.path);

      }
     else if(numberfile == 3){

        imagefile3 = File(pickedFile.path);

      }
    }
    Navigator.pop(context);
    refresh();
  }
  void showimgdialog(int numberFile){
    Widget cameraButton = ElevatedButton(
        onPressed: (){selectimg(ImageSource.gallery,numberFile);}, child: Text('Galeria')
    );Widget galleyButton = ElevatedButton(
        onPressed: (){selectimg(ImageSource.camera,numberFile);}, child: Text('Camara')
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
}