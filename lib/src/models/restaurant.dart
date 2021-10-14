// To parse this JSON data, do
// To parse this JSON data, do
//
//     final restaurant = restaurantFromJson(jsonString);

import 'dart:convert';

Restaurant restaurantFromJson(String str) => Restaurant.fromJson(json.decode(str));

String restaurantToJson(Restaurant data) => json.encode(data.toJson());

class Restaurant {

  String id;
  String name;
  String description;
  String image1;
  String idUser;
  String idCategory;
  List<Restaurant> toList =[];

  Restaurant({
    this.id,
    this.name,
    this.description,
    this.image1,
    this.idUser,
    this.idCategory,
    this.toList,
  });



  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
    id: json["id_res"] is int ? json["id_res"].toString():json["id_res"],
    name: json["name"],
    description: json["description"],
    image1: json["image1"],
    idUser: json["id_user"]is int ? json["id_user"].toString():json["id_user"],
    idCategory: json["id_category"] is String ? int.parse(json["id_category"]):json["id_category"],
  );

  Restaurant.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null)return;
    jsonList.forEach((item) {
      Restaurant restaurant = Restaurant.fromJson(item);
      toList.add(restaurant);
    });
  }

  Map<String, dynamic> toJson() => {
    "id_res": id,
    "name": name,
    "description": description,
    "image1": image1,
    "id_user": idUser,
    "id_category": idCategory,
  };
}
