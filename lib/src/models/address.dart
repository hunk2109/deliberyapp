// To parse this JSON data, do
//
//     final address = addressFromJson(jsonString);

import 'dart:convert';

Address addressFromJson(String str) => Address.fromJson(json.decode(str));

String addressToJson(Address data) => json.encode(data.toJson());

class Address {
  String id;
  String idUser;
  String address;
  String neightborhood;
  double lat;
  double lng;
  List<Address> toList =[];

  Address({
    this.id,
    this.idUser,
    this.address,
    this.neightborhood,
    this.lat,
    this.lng,
  });



  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"] is int ?  json["id"].toString():  json["id"],
    idUser: json["id_user"],
    address: json["address"],
    neightborhood: json["neightborhood"],
    lat: json["lat"] is String ? double.parse( json["lat"]): json["lat"].toDouble(),
    lng: json["lng"] is String ? double.parse( json["lng"]):json["lng"].toDouble(),
  );

  Address.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null)return;
    jsonList.forEach((item) {
      Address address =Address.fromJson(item);
      toList.add(address);
    });
  }
  Map<String, dynamic> toJson() => {
    "id": id,
    "id_user": idUser,
    "address": address,
    "neightborhood": neightborhood,
    "lat": lat,
    "lng": lng,
  };
}
