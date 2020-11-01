//import 'map_screen.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:http/http.dart' as http;
//import 'dart:convert';
//const apiKey = 'AIzaSyBerIytX6hL8AicPKOWHG12YQOpRqv9fFE';
////const apiKey = '5b3ce3597851110001cf624845fc27e5a2e24a8b8b03bea1387a819e';
//
//
//class GoogleMapServices{
//  Future<String> getRouteCoordinates(LatLng l1 , LatLng l2) async{
//    String url = 'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$apiKey&start=${l1.latitude},${l1.longitude}&${l2.latitude},${l2.longitude}';
//    http.Response response = await http.get(url);
//    Map values = jsonDecode(response.body);
//    return values["features"][0]["metadata"]["service"];
//
//  }
//}


//'https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=$apiKey';



import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
const apiKey = "AIzaSyCXMGIj3qGvauZ0GKo7xlSKMHhZx9xJVhg";
class GoogleMapServices {
  Future getRouteCoordinates(LatLng l1, LatLng l2)async{
    String url = "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude}, ${l2.longitude}&key=$apiKey";
    http.Response response = await http.get(url);
    Map values = jsonDecode(response.body);
    return values["routes"][0]["overview_polyline"]["points"];
  }
}