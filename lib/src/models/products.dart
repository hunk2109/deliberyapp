// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

Products productsFromJson(String str) => Products.fromJson(json.decode(str));

String productsToJson(Products data) => json.encode(data.toJson());

class Products {
  String id;
  String name;
  String description;
  String image1;
  String image2;
  String image3;
  int idCategory;
  double price;
  int quantity;
  List<Products> toList = [];

  Products({
    this.id,
    this.name,
    this.description,
    this.image1,
    this.image2,
    this.image3,
    this.idCategory,
    this.price,
    this.quantity,
  });



  factory Products.fromJson(Map<String, dynamic> json) => Products(
    id: json["id"] is int ? json["id"].toString():json["id"],
    name: json["name"],
    description: json["description"],
    image1: json["image1"],
    image2: json["image2"],
    image3: json["image3"],
    idCategory: json["id_category"] is String ? int.parse(json["id_category"]):json["id_category"],
    price: json['price'] is String ? double.parse(json["price"]):isInteger( json["price"])? json["price"].toDouble():json["price"],
    quantity: json["quantity"],
  );

  Products.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null)return;
    jsonList.forEach((item) {
      Products products =Products.fromJson(item);
      toList.add(products);
    });
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "image1": image1,
    "image2": image2,
    "image3": image3,
    "id_category": idCategory,
    "price": price,
    "quantity": quantity,
  };

  static bool isInteger(num values) => values is int|| values == values.roundToDouble();
}
