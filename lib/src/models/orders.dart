// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

import 'package:delivey/src/models/products.dart';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());


class Order {
  String id;
  String idClient;
  String aidDelibery;
  String idAddress;
  String status;
  double lat;
  double lng;
  int timestap;
  List<Products> products =[];
  List<Order> toList = [];

  Order({
    this.id,
    this.idClient,
    this.aidDelibery,
    this.idAddress,
    this.status,
    this.lat,
    this.lng,
    this.timestap,
    this.products,
  });



  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"] is int ?  json["id"].toString():  json["id"],
    idClient: json["id_client"],
    aidDelibery: json["aid_delibery"],
    idAddress: json["id_address"],
    status: json["status"],
    lat: json["lat"] is String ? double.parse(json["lat"]):json["lat"] ,
    lng: json["lng"] is String ? double.parse(json["lng"]):json["lng"] ,
    timestap: json["timestap"] is String ? int.parse(json["timestap"]): json["timestap"],
    products: List<Products>.from(json["products"].map((model) => Products.fromJson(model))) ?? [],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_client": idClient,
    "aid_delibery": aidDelibery,
    "id_address": idAddress,
    "status": status,
    "lat": lat,
    "lng": lng,
    "timestap": timestap,
    "products": products
  };
}
