// To parse this JSON data, do
//
//     final biscategories = biscategoriesFromJson(jsonString);

import 'dart:convert';

Biscategories biscategoriesFromJson(String str) => Biscategories.fromJson(json.decode(str));

String biscategoriesToJson(Biscategories data) => json.encode(data.toJson());

class Biscategories {
  String id;
  String name;
  String description;
  List<Biscategories> toList =[];

  Biscategories({
    this.id,
    this.name,
    this.description,
  });



  factory Biscategories.fromJson(Map<String, dynamic> json) => Biscategories(
    id: json["id"] is int ? json["id"].toString():json["id"],
    name: json["name"],
    description: json["description"],
  );

  Biscategories.fromjsonList(List<dynamic>jsonList){
    if(jsonList == null) return;
    jsonList.forEach((item) {
      Biscategories biscategories = Biscategories.fromJson(item);
      toList.add(biscategories);

    });
  }
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
  };
}
