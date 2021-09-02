import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:location/location.dart' as location;

class DeliberyAdrresMapController{
  BuildContext context;
  Function refresh;
  Position _position;

  String addressName;
  LatLng addresslatlgn;

  CameraPosition initPosition = CameraPosition(target: LatLng(19.3376678, -70.9381985),
      zoom: 16
  );

  Completer<GoogleMapController> _mapController = Completer();
  BitmapDescriptor deliberyMarker;
  Map<MarkerId,Marker> markers = <MarkerId,Marker>{


  };

  Future init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    deliberyMarker = await createMarkerfromAsset('assets/img/delivery2.png');//
    checkGps();
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

  void updateLocation() async{
    try{

      await _determinePosition(); // determisr pocision y permisos
      _position = await Geolocator.getLastKnownPosition(); //Lat y Lon
      animatedCamera(_position.latitude, _position.longitude);
      addMarker('Delibery', _position.latitude, _position.longitude, 'Tu Posicion', '', deliberyMarker);
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
        zoom: 12,
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