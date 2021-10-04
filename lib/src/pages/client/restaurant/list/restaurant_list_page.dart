import 'package:delivey/src/models/products.dart';
import 'package:delivey/src/pages/client/restaurant/list/restaurant_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:delivey/src/pages/client/produts/list/clint_products_list_controller.dart';
import 'package:flutter/scheduler.dart';
import 'package:delivey/src/utils/my_colors.dart';
import 'package:delivey/src/models/categories.dart';
import 'package:delivey/src/widgets/no_data_widgets.dart';



class RestaurentListPage extends StatefulWidget {
  const RestaurentListPage({Key key}): super(key: key);

  @override
  _RestaurentListPageState createState() => _RestaurentListPageState();
}

class _RestaurentListPageState extends State<RestaurentListPage> {
  RestaurentListController _con = new RestaurentListController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context,refresh);
    });
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _con.categories?.length,
      child: Scaffold(
        key: _con.key,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(170),
          child:AppBar(
            automaticallyImplyLeading: false,
            actions: [_shopinbag()],
            flexibleSpace: Column(
              children: [
                SizedBox(height: 30,),
                _menuDrawer(),
                SizedBox(height: 30,),
                _textFieldSearch()
              ],
            ),
            bottom: TabBar(
              indicatorColor: MyColors.prymaryColor,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey[400],
              isScrollable: true,
              tabs: List<Widget>.generate(_con.categories.length,(index){
                return  Tab(

                    child: Text(_con.categories[index].name ?? ''),

                  );


              }),
            ),
            backgroundColor: Colors.white ,

          )
        ),
        drawer: _drawer(),
        body: TabBarView(
          children: _con.categories.map((Category category) {
                 return FutureBuilder(
                     future: _con.getProducts(category.id,_con.productName),

                     builder: (context, AsyncSnapshot<List<Products>> snapshot){
                       if(snapshot.hasData){
                         if(snapshot.data.length > 0){
                           return GridView.builder(
                               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                                 crossAxisCount: 2,
                                 childAspectRatio: 0.7,
                               ),
                               itemCount: snapshot.data?.length??0,
                               itemBuilder: (_,index){
                                 return _carProduct(snapshot.data[index]);
                               }
                           );
                         }
                         else{
                           return NodataWidget(text:'No hay Productos',

                           );
                         }
                       }
                       else{
                         return NodataWidget(text:'No hay Productos',);
                       }


                 }
                 );
            //_carProduct();
            }).toList(),

        )
      ),
    );
  }

  Widget _carProduct(Products products){
    return GestureDetector(
      onTap: (){
        _con.openBottonSheet(products);
      },
      child: Container(
        height: 250,
        child: Card(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          child: Stack(
            children: [
              Positioned(
                top: -1.0,
                  right: 1.0,
                  child:
                  Container(
                width: 40,
                height: 40,
                decoration:BoxDecoration(
                  color: MyColors.prymaryColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      topRight: Radius.circular(20)),
                ),
                      child: Icon(Icons.add, color: Colors.white,),
              ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top:20),
                    height: 150,
                    width: MediaQuery.of(context).size.width*0.45,
                    padding: EdgeInsets.all(20),
                    child: FadeInImage(
                      image: products.image1 != null
                          ?NetworkImage(products.image1):

                      AssetImage('assets/img/no-image.png'),
                      fit: BoxFit.contain,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder:AssetImage('assets/img/no-image.png'),
                    ),

                  ),
                  Container(
                    height: 40,
                    margin:EdgeInsets.symmetric(horizontal: 20),
                    child: Text(products.name ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    ),

                  ),
                  Spacer(),
                  Container(
                    margin:EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                    child: Text('${products.price ?? 0}\$',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,

                    ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _textFieldSearch(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        onChanged: _con.onChangetxt,
        decoration: InputDecoration(
          hintText: 'Buscar',
          suffixIcon: Icon(Icons.search,
            color: Colors.grey[400]
          ),
          hintStyle: TextStyle(
            fontSize: 17,
            color: Colors.grey[500],
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Colors.grey[300]
            ),
          ),
          focusedBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
                color: Colors.grey[300]
            ),
          ),
          contentPadding: EdgeInsets.all(15)
        ),
      )
    );
  }
  Widget _shopinbag(){
    return GestureDetector(
      onTap: _con.gotocheckorder,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(right: 15,top:13),
            child: Icon(
              Icons.shopping_bag_outlined,
              color: Colors.black,
            ),
          ),
          Positioned(
            right: 16,
            top:15,
            child: Container(
            width: 9,
            height: 9,
             decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(30))
            ),
          ),
          ),
        ],
      ),
    );
  }
  Widget _menuDrawer(){
    return GestureDetector(
      onTap: _con.openDrawer,
      child: Container(
        margin: EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child:Image.asset('assets/img/menu.png', width: 20,height: 20,)
      ),
    );
  }

  Widget _drawer(){
    return Drawer(

      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration:BoxDecoration(
                  color: MyColors.prymaryColor
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

            children:[
              Text(
              '${_con.users?.name ?? ''} ${_con.users?.lastname ?? ''}',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
                maxLines: 1,
              ),
              Text(
                '${_con.users?.email??''}',
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[300],
                    fontWeight: FontWeight.bold
                ),
                maxLines: 1,
              ),
              Text(
                '${_con.users?.phone?? ''}',
                style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[200],
                    fontWeight: FontWeight.bold
                ),
                maxLines: 1,
              ),

              Container(
                height: 60,
                margin: EdgeInsets.only(top: 10),
                child: FadeInImage(
                  image: _con.users?.image != null
                      ? NetworkImage(_con.users?.image)
                 : AssetImage('assets/img/no-image.png'),
                  fit:BoxFit.contain,
                  fadeInDuration: Duration(milliseconds: 50),
                  placeholder:AssetImage('assets/img/no-image.png'),
                ),
              )

            ],
          )
          ),
         ListTile(
           onTap:_con.gotoUpdate,
           title: Text('Editar Perfil'),
           trailing: Icon(Icons.edit_outlined),

         ),
          ListTile(
            onTap: _con.gotoOrdersList,
            title: Text('Mis pedidos'),
            trailing: Icon(Icons.shopping_cart_outlined),


          ),
          _con.users != null ?
              _con.users.roles.length >1?
          ListTile(
            onTap: _con.gotoRoles,
            title: Text('Cambiar Rol'),
            trailing: Icon(Icons.person_outlined),

          ):Container():Container(),
          ListTile(
            title: Text('Cerrar Sesion'),
            trailing: Icon(Icons.power_settings_new),
            onTap: _con.logout,

          ),


        ],
      ),
    );
  }


  void refresh(){
    setState((){

    });
  }
}
