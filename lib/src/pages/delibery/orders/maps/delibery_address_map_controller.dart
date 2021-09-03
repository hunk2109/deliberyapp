import 'package:delivey/src/models/orders.dart';
import 'package:delivey/src/models/response_api.dart';
import 'package:delivey/src/models/user.dart';
import 'package:delivey/src/provider/order_provider.dart';
import 'package:delivey/src/utils/my_colors.dart';
import 'package:delivey/src/utils/mysnackbar.dart';
import 'package:delivey/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:location/location.dart' as location;
import 'package:delivey/src/api/enviroment.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';

class DeliberyAdrresMapController{
  BuildContext context;
  Function refresh;
  Position _position;
  StreamSubscription _positionStream;
  String addressName;
  LatLng addresslatlgn;

  CameraPosition initPosition = CameraPosition(target: LatLng(19.3376678, -70.9381985),
      zoom: 15
  );

  Completer<GoogleMapController> _mapController = Completer();
  BitmapDescriptor deliberyMarker;
  BitmapDescriptor toMarker;
  Map<MarkerId,Marker> markers = <MarkerId,Marker>{};

  Order order;
  Set<Polyline> polylines ={};
  List<LatLng> points = [];
  OrderProvider _ordersProvider = new OrderProvider();
  Users users;
  SharedPref _sharedPref = new SharedPref();
  double _deliberyPositionDistance;

  Future init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    order = Order.fromJson(ModalRoute.of(context).settings.arguments as Map<String, dynamic>);
    deliberyMarker = await createMarkerfromAsset('assets/img/delivery2.png');//
    toMarker = await createMarkerfromAsset('assets/img/home.png');//
    users = Users.fromJson(await _sharedPref.read('user'));
    _ordersProvider.init(context, users);
    print('Orden: ${order.toJson()}');
    checkGps();
  }

  void updateToDelivered() async{
    if(_deliberyPositionDistance <= 200){

      ResponseApi responseApi = await _ordersProvider.updatetoDelibered(order);
      if(responseApi.succes){
        Fluttertoast.showToast(msg: responseApi.message, toastLength: Toast.LENGTH_LONG);
        Navigator.pushNamedAndRemoveUntil(context, 'delibery/orders/list', (route) => false);
      }
    }

    else{
      MySnackbar.show(context, 'Aun estas Demaciado lejos para confirmar la entrega');
    }

    print('Distancia: ${_deliberyPositionDistance}');


  }

  void isCloseToDelivered(){
    _deliberyPositionDistance = Geolocator.distanceBetween(_position.latitude,
        _position.longitude,
        order.address.lat,
        order.address.lng

    );

    print('Distancia: ${_deliberyPositionDistance}');
  }
  Future<void> setPolylines(LatLng from,LatLng to) async{
    PointLatLng pointfrom = PointLatLng(from.latitude, from.longitude);
    PointLatLng pointto = PointLatLng(to.latitude, to.longitude);
    PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(Enviroment.API_Delibery_Maps, pointfrom, pointto);
    for(PointLatLng poin in result.points){
      points.add(LatLng(poin.latitude,poin.longitude));
    }

    Polyline polyline = Polyline(polylineId: PolylineId('poly'),
    color: MyColors.prymaryColor,
    points: points,
    width: 6);
    polylines.add(polyline);
    refresh();
  }
  void addMarker(String markerid,double lat,double lng,String title,String content, BitmapDescriptor iconMarker){

    MarkerId id = MarkerId(markerid);
    Marker marker = Marker(markerId: id,
    icon: iconMarker,
    position: LatLng(lat,lng),
    infoWindow: InfoWindow(title: title,snippet: content),
    );

    markers[id] = marker;
    refresh();


  }
  Future<Null> setLocationDraggableIng() async{

    if(initPosition != null){
      double lat = initPosition.target.latitude;
      double lgn = initPosition.target.longitude;

      List<Placemark> address = await placemarkFromCoordinates(lat, lgn);

      if(address != null){
        if(address.length >0){
          String direction = address[0].thoroughfare;
          String street = address[0].subThoroughfare;
          String city = address[0].locality;
          String departament = address[0].administrativeArea;
          String country = address[0].country;
          addressName = '$direction #$street, $city, $departament';
          addresslatlgn = new LatLng(lat, lgn);

          refresh();
        }

      }

    }
  }


  Future<BitmapDescriptor> createMarkerfromAsset(String path) async{

    ImageConfiguration conf = ImageConfiguration();
    BitmapDescriptor descriptor = await BitmapDescriptor.fromAssetImage(conf, path);
    return descriptor;

  }
  void onMapCreated(GoogleMapController controller){
    controller.setMapStyle('[{"elementType":"geometry","stylers":[{"color":"#f5f5f5"}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#f5f5f5"}]},{"featureType":"administrative.land_parcel","elementType":"labels.text.fill","stylers":[{"color":"#bdbdbd"}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#eeeeee"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#e5e5e5"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"road","elementType":"geometry","stylers":[{"color":"#ffffff"}]},{"featureType":"road.arterial","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#dadada"}]},{"featureType":"road.highway","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"transit.line","elementType":"geometry","stylers":[{"color":"#e5e5e5"}]},{"featureType":"transit.station","elementType":"geometry","stylers":[{"color":"#eeeeee"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#c9c9c9"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]}]');
    _mapController.complete(controller);
  }

  void call(){
    launch('tel://${order?.client?.phone}');
  }

  void dispose(){
    _positionStream?.cancel();
  }
  void updateLocation() async{
    try{

      await _determinePosition(); // determisr pocision y permisos
      _position = await Geolocator.getLastKnownPosition(); //Lat y Lon
      animatedCamera(_position.latitude, _position.longitude);
      addMarker('Delibery', _position.latitude, _position.longitude, 'Tu Posicion', '', deliberyMarker);
      addMarker('home', order.address.lat, order.address.lng, 'Entrega', '', toMarker);

      LatLng from = new LatLng(_position.latitude, _position.longitude);
      LatLng to = new LatLng(order.address.lat, order.address.lng);
      setPolylines(from, to);

      _positionStream = Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.best,
      distanceFilter: 1).listen((Position position) {

        _position = position;

        addMarker('Delibery', _position.latitude, _position.longitude, 'Tu Posicion', '', deliberyMarker);

        animatedCamera(_position.latitude, _position.longitude);
        isCloseToDelivered();

        refresh();


      });

    }
    catch(e){
      print('Error: $e');

    }

  }

  void checkGps() async{
    bool isLocationOn = await Geolocator.isLocationServiceEnabled();
    if(isLocationOn){
      updateLocation();
    }
    else{
      bool locatioGps = await location.Location().requestService();
      if(locatioGps){
        updateLocation();

      }
    }
  }
  Future animatedCamera(double lat, double lon) async{

    GoogleMapController controller = await _mapController.future;
    if(controller != null){
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(lat,lon),
        zoom: 15,
        bearing: 0,
      )));
    }

  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void selectRefpoint(){

    Map<String, dynamic> data ={
      'address': addressName,
      'lat': addresslatlgn.latitude,
      'lng': addresslatlgn.longitude
    };
    Navigator.pop(context,data);
  }

}