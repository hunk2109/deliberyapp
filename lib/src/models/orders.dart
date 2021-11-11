import 'dart:convert';

import 'package:delibery/src/models/address.dart';
import 'package:delibery/src/models/products.dart';
import 'package:delibery/src/models/user.dart';




Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());


class Order {
  String id;
  String idClient;
  String idRestaurant;
  String restName;
  String idDelibery;
  String idAddress;
  String status;
  double lat;
  double lng;
  int timestamp;
  List<Products> products =[];
  List<Order> toList = [];
  Users client;
  Address address;
  Users delibery;

  Order({
    this.id,
    this.idClient,
    this.idDelibery,
    this.idAddress,
    this.idRestaurant,
    this.restName,
    this.status,
    this.lat,
    this.lng,
    this.timestamp,
    this.products,
    this.client,
    this.address,
    this.delibery,
  });



  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"] is int ?  json["id"].toString():  json["id"],
    idClient: json["id_client"],
    idDelibery: json["id_delibery"],
    idAddress: json["id_address"],
    idRestaurant: json["id_restaurant"],
    restName: json["rest_name"],
    status: json["status"],
    lat: json["lat"] is String ? double.parse(json["lat"]):json["lat"] ,
    lng: json["lng"] is String ? double.parse(json["lng"]):json["lng"] ,
    timestamp: json["timestamp"] is String ? int.parse(json["timestamp"]): json["timestmap"],
    products:json["products"]!= null ? List<Products>.from(json["products"].map((model) => model  is Products ? model: Products.fromJson(model))) ?? []:[],
    client: json['client'] is String ? usersFromJson(json['client']): json['client'] is Users ? json['client']: Users.fromJson(json['client'] ??[]),
    address: json['address'] is String ? addressFromJson(json['address']): json['address'] is Address ? json['address']: Address.fromJson(json['address'] ??[]),
    delibery: json['delibery'] is String ? usersFromJson(json['delibery']): json['delibery'] is Users ? json['delibery']: Users.fromJson(json['delibery'] ??[]),

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
    "id_delibery": idDelibery,
    "id_restaurant": idRestaurant,
    "rest_name": restName,
    "id_address": idAddress,
    "status": status,
    "lat": lat,
    "lng": lng,
    "timestap": timestamp,
    "products": products,
    "client": client,
    "address":address,
    'delibery':delibery,
  };
}