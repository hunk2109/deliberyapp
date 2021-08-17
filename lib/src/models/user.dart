import 'dart:convert';
import 'package:delivey/src/models/roles.dart';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {

  String id;
  String name;
  String lastname;
  String email;
  String phone;
  String password;
  String sessionToken;
  String image;
  List<Rol> roles =[];
  
  Users({
    this.id,
    this.name,
    this.lastname,
    this.email,
    this.phone,
    this.password,
    this.sessionToken,
    this.image,
    this.roles,

  });



  factory Users.fromJson(Map<String, dynamic> json) => Users(
    id: json["id"] is int ? json['id'].toString():  json["id"],
    name: json["name"],
    lastname: json["lastname"],
    email: json["email"],
    phone: json["phone"],
    password: json["password"],
    sessionToken: json["session_token"],
    image: json["image"],
    roles: json["roles"]== null?[]:List<Rol>.from(json['roles'].map((model)=>Rol.fromJson(model)))??[],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "lastname": lastname,
    "email": email,
    "phone": phone,
    "password": password,
    "session_token": sessionToken,
    "image": image,
    "roles": roles,
  };
}
