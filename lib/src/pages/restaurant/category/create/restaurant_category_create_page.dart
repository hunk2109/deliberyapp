import 'package:flutter/material.dart';

class RestaurantCategoryCreatePage extends StatefulWidget {
  const RestaurantCategoryCreatePage({Key key}) : super(key: key);
  @override
  _RestaurantCategoryCreatePageState createState() => _RestaurantCategoryCreatePageState();
}

class _RestaurantCategoryCreatePageState extends State<RestaurantCategoryCreatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categorias'),
      ),
    );
  }
}
