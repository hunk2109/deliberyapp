import 'dart:convert';
import 'package:delivey/src/models/restaurant.dart';
import 'package:delivey/src/models/roles.dart';
import 'package:delivey/src/provider/restaurant_provider.dart';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {

  String id;
  String name;
  String lastname;
  int idRestaurant;
  String email;
  String phone;
  String password;
  String sessionToken;
  String notificationToken;
  String image;
  List<Rol> roles =[];
  List<Users> toList = [];
  List<Restaurant> Res =[];

  
  Users({
    this.id,
    this.name,
    this.lastname,
    this.idRestaurant,
    this.email,
    this.phone,
    this.password,
    this.sessionToken,
    this.notificationToken,
    this.image,
    this.roles,
    this.Res,


  });



  factory Users.fromJson(Map<String, dynamic> json) => Users(
      id: json["id"] is int ? json['id'].toString():json["id"],
      name: json["name"],
      lastname: json["lastname"],
      email: json["email"],
      idRestaurant: json["id_resturant"] is int ? json["id_resturant"].toString():json["id_resturant"],
      phone: json["phone"],
      password: json["password"],
      sessionToken: json["session_token"],
      notificationToken: json["notification_token"],
      image: json["image"],
      roles: json["roles"]== null?[]:List<Rol>.from(json['roles'].map((model)=>Rol.fromJson(model)))??[],
      Res: json["restaurant"] == null?[]:List<Restaurant>.from(json['restaurant'].map((model)=>Restaurant.fromJson(model)))??[]

  );

  Users.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null)return;
    jsonList.forEach((item) {
      Users users =Users.fromJson(item);
      toList.add(users);
    });
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "lastname": lastname,
    "email": email,
    "phone": phone,
    "password": password,
    "session_token": sessionToken,
    "notification_Token": notificationToken,
    "id_resturant": idRestaurant,
    "image": image,
    "roles": roles,
    "Res": Res,
  };
}

