// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

import 'package:delivey/src/models/address.dart';
import 'package:delivey/src/models/products.dart';
import 'package:delivey/src/models/user.dart';

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
  int timestamp;
  List<Products> products =[];
  List<Order> toList = [];
  Users client;
  Address address;

  Order({
    this.id,
    this.idClient,
    this.aidDelibery,
    this.idAddress,
    this.status,
    this.lat,
    this.lng,
    this.timestamp,
    this.products,
    this.client,
    this.address,
  });



  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"] is int ?  json["id"].toString():  json["id"],
    idClient: json["id_client"],
    aidDelibery: json["aid_delibery"],
    idAddress: json["id_address"],
    status: json["status"],
    lat: json["lat"] is String ? double.parse(json["lat"]):json["lat"] ,
    lng: json["lng"] is String ? double.parse(json["lng"]):json["lng"] ,
    timestamp: json["timestamp"] is String ? int.parse(json["timestamp"]): json["timestmap"],
    products:json["products"]!= null ? List<Products>.from(json["products"].map((model) => Products.fromJson(model))) ?? []:[],
    client: json['client'] is String ? usersFromJson(json['client']): Users.fromJson(json['client'] ??[]),
    address: json['address'] is String ? addressFromJson(json['address']): Address.fromJson(json['address'] ??[]),

  );

  Order.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null)return;
    jsonList.forEach((item) {
      Order order =Order.fromJson(item);
      toList.add(order);
    });
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_client": idClient,
    "aid_delibery": aidDelibery,
    "id_address": idAddress,
    "status": status,
    "lat": lat,
    "lng": lng,
    "timestap": timestamp,
    "products": products,
    "client": client,
    "address":address,
  };
}
