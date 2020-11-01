import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
//import 'package:google_maps_webservice/places.dart';
import 'package:location/location.dart';
//import 'package:location/location.dart';
import 'dart:math';
import 'dart:async';
//import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:parking/pages/Aboutus.dart';
import 'package:parking/pages/FAQ.dart';
import 'package:parking/pages/myaccountspage.dart';
import 'package:parking/pages/myorderspage.dart';
import 'package:parking/screens/google_map_services.dart';
import 'package:http/http.dart' as http;
import 'package:parking/sidebar/menu_item.dart';
import '../flutter_google_places_autocomplete.dart';
import 'login_screen.dart';

//const kGoogleApiKey = "AIzaSyBerIytX6hL8AicPKOWHG12YQOpRqv9fFE";
//GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class MapScreen extends StatefulWidget {
  static const String id = 'map_screen';

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController mapController;
  String locationAddress = "Search destination";
  String myLocation = "";
//  GooglePlaces googlePlaces;
  bool _isLoading = false;
  double _destinationLat;
  double _destinationLng;

  // Location location = new Location();
  static LatLng _lastPosition;
  GoogleMapServices _googleMapServices = GoogleMapServices();
  Position currentLocation;
  LocationData currentLocations;
  LatLng _initialPosition;
  LatLng get lastposition => _lastPosition;
  final Set<Polyline> _polyLines = {};
  Set<Polyline> get polyLines => _polyLines;
  static LatLng latLng;
//  LatLng markerlocvalue;
  bool restToggle = false;
  bool mapToggle = false;
  bool clientsToggle = false;
  var searchAddress;
  var currentClient;
  var currentBearing;
  var snapshot;
  var searchaddress;
  var inputaddr = '';
  var intendedLocation;

  MapType _currentMapType = MapType.normal;
  final Set<Marker> _markers = {};

  final Set<Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints _polylinePoints = PolylinePoints();

  getLocation() async {
    var location = new Location();
    location.onLocationChanged.listen((currentLocations) {
      print(currentLocations.latitude);
      print(currentLocations.longitude);
      setState(() {
        this.currentLocations = currentLocations;
        latLng = LatLng(currentLocations.latitude, currentLocations.longitude);
      });
      print("getLocation:$latLng");

//    loading = false;
    });
  }

  _onMapTypeButtonPressed() {
    if (!mounted) return;
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

//
//  _onAddMarkerButtonPressed(LatLng latLng) {
//   // _markers.clear();
//    setState(() {
////      Firestore.instance.collection('markers').add({
////        'location' : new GeoPoint(latLng.latitude, latLng.longitude)
////      });
//      _markers.add(Marker(
//        markerId: MarkerId("${Random().nextInt(100)}"),
//        infoWindow: InfoWindow(
//          title: 'parking here',
//        ),
//        icon: BitmapDescriptor.defaultMarker,
//        position: LatLng(latLng.latitude, latLng.longitude),
//        draggable: false,
////        onTap: (){
////          _markers.remove(_markers.firstWhere(Marker _mar))
////        }
//      ));
//
//      _addToList();
//    });
//  }
//  Future <void> searchAutoComplete() async{
//    try{
//      final center = await getUserLocation();
//      Prediction p = await PlacesAutocomplete.show(
//        context: context,
//        apiKey: kGoogleApiKey,
//        language: 'en',
//        components: [Component(Component.country,'en')],
//        mode: Mode.overlay,
//        strictbounds: center == null ? false : true ,
//        location: center == null ? null : Location(center.latitude,center.longitude),
//        radius: center == null ? null : 1000
//      );
//      showDetailPlace(p.placeId);
//    }catch(e){
//      return;
//    }
//  }
//  Future<Null> showDetailPlace(String placeId) async {
//    if (placeId != null) {
//      Navigator.push(
//        context,
//        MaterialPageRoute(builder: (context) => MapScreen()),
//      );
//    }
//  }

  Widget clientCard(client) {
    return Padding(
        padding: EdgeInsets.only(left: 2.0, top: 10.0),
        child: InkWell(
            onTap: () {
              if (!mounted) return;
              setState(() {
                currentClient = client;
                currentBearing = 90.0;
              });
              zoomInMarker(client);
            },
            child: Material(
              elevation: 4.0,
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                  height: 100.0,
                  width: 125.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.blue),
                  child: Center(child: Text(client['location']))),
            )));
  }

  zoomInMarker(client) {
    mapController
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(snapshot.data.documents['location'].latitude,
                snapshot.data.documents['location'].longitude),
            zoom: 17.0,
            bearing: 90.0,
            tilt: 45.0)))
        .then((val) {
      if (!mounted) return;
      setState(() {
        restToggle = true;
      });
    });
  }

  _addToList() async {
    final query = inputaddr;
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    var first = addresses.first;
    Firestore.instance.collection('markers').add({
      'location':
          new GeoPoint(first.coordinates.latitude, first.coordinates.longitude)
    });
    if (!mounted) return;
    setState(() {
      currentLocations = first as LocationData;
//      currentLocation = first as Position;
    });
  }

  addMarker() async {
    await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new SimpleDialog(
            title: new Text(
              'Add Marker',
              style: new TextStyle(fontSize: 17.0),
            ),
            children: <Widget>[
              new TextField(
                onChanged: (String enteredLoc) {
                  if (!mounted) return;
                  setState(() {
                    inputaddr = enteredLoc;
                  });
                },
              ),
              new SimpleDialogOption(
                child: new Text('Add It',
                    style: new TextStyle(color: Colors.blue)),
                onPressed: () {
                  _addToList();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Widget _loadMap() {
    //MarkerId markerId;
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('markers').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
              child: Text(
            'please wait...',
            style: TextStyle(fontSize: 15.0),
          ));
        }
        for (int i = 0; i < snapshot.data.documents.length; i++) {
          MarkerId markerId = MarkerId("${Random().nextInt(100)}");
          final marker = snapshot.data.documents[i]['location'] as GeoPoint;
          _markers.add(Marker(
            markerId: markerId,
            //MarkerId("${Random().nextInt(100)}"),
            infoWindow: InfoWindow(
              title: 'parking here',
            ),
            icon: BitmapDescriptor.defaultMarker,
            position: LatLng(marker.latitude, marker.longitude),
            draggable: false,
            onTap: () {},
//            => sendRequest(intendedLocation),
//           selectedMarker( markerId);
//                sendRequest(LatLng(marker.latitude, marker.longitude));
          ));
        }
        return GoogleMap(
          markers: _markers,
          polylines: polylines,
          mapType: _currentMapType,
          scrollGesturesEnabled: true,
          rotateGesturesEnabled: true,
          compassEnabled: true,
          myLocationEnabled: true,
          tiltGesturesEnabled: true,
          indoorViewEnabled: true,
          zoomGesturesEnabled: true,
          mapToolbarEnabled: true,
          onMapCreated: _onMapCreated,
          myLocationButtonEnabled: true,
          initialCameraPosition: CameraPosition(
              target: latLng,
//              _initialPosition =
//                  LatLng(currentLocation.latitude, currentLocation.longitude),
              zoom: 12.0),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        getLocation();
      });
    });

  }

  sendRequest(String intendedLocation) async {
    _isLoading = true;
    List placemark = await Geolocator().placemarkFromAddress(intendedLocation);
    double latitude = placemark[0].position.latitude;
    double longitude = placemark[0].position.longitude;
    LatLng destination = LatLng(latitude, longitude);
//      _marker(destination);
    _markers;
    String route =
        await _googleMapServices.getRouteCoordinates(latLng, destination);
    createRoute(route);
  }

  createRoute(String encondedPoly) {
    _polyLines.add(Polyline(
        polylineId: PolylineId(latLng.toString()),
        width: 4,
        points: _convertToLatLng(_decodePoly(encondedPoly)),
        color: Colors.blue));
    _isLoading = false;
  }

  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;
    do {
      var shift = 0;
      int result = 0;
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];
    print(lList.toString());
    return lList;
  }

//  void sendRequest(LatLng destination) async {
//    _initialPosition =
//        LatLng(currentLocation.latitude, currentLocation.longitude);
////    LatLng _destination = LatLng(markerlocation.latitude,markerlocation.longitude);
//    String route = await _googleMapServices.getRouteCoordinates(
//        _initialPosition, destination);
//    print(route);
//    createRoute(route);
//  }

//  getMarkerLocation() async {
//    //dynamic  markerLocation = LocationData ;
//    var location = new Location();
//    var error;
//    try {
//      markerlocation = await location.getLocation();
//      //lat = markerLocation.latitude;
//      //lon = markerLocation.longitude;
//      //print(lon);
//      //double lat =  markerlocation.latitude;
//      //double lng= markerlocation.longitude;
//      markerlocvalue =
//          LatLng(markerlocation.latitude, markerlocation.longitude);
//      //destination = LatLng(lat,lng);
//      return markerlocvalue;
//    } on PlatformException catch (e) {
//      if (e.code == 'PERMISSION_DENIED') {
//        error = 'permission denied';
//      }
//      markerlocation = null;
//    }
//  }

//  void selectedMarker(MarkerId markerId) {
//    getMarkerLocation();
//    //final Marker tappedMarker = campusMarkers.elementAt(int.parse(markerId.value));
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        automaticallyImplyLeading: false, // Don't show the leading button

        title: new Text('Erkenly'),
        centerTitle: true,
        toolbarOpacity: 0.7,

        actions: <Widget>[
          InkWell(
            child: Icon(
              Icons.add,
              size: 28.0,
            ),
            onTap: () => addMarker(),
          ),
          SizedBox(width: 20)
        ],
//        leading:
//        new IconButton(
//            icon: Icon(Icons.menu),
//
//            onPressed: () {
//              Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => SideBarLayout()),
//              );
//            }),
      ),
      drawer: new Drawer(
        child:Container(
          color: Colors.blue.shade300,

          child:  ListView(

            children: <Widget>[

              new Container(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: new DrawerHeader(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "Erknly",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w800),
                        ),
                        subtitle: Text(
                          "Erkenly is the best app for parking",
                          style: TextStyle(
                            color: Color(0xFF1BB5FD),
                            fontSize: 15,
                          ),
                        ),
                        leading: CircleAvatar(
                          radius: 40.0,
                          backgroundImage: AssetImage("images/erknly.jpg"),
                        ),
                      ),
                      Divider(
                        height: 44,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.3),
                        indent: 32,
                        endIndent: 32,
                      ),
                    ],
                  ),
                ),
                color: Colors.blue.shade600,
              ),
              new Container(
                color: Colors.blue.shade300,
                child: new Column(
                  children: <Widget>[
                    MenuItem(
                      icon: Icons.home,
                      title: "Home",
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.pushNamed(context, MapScreen.id);

                      },
                    ),
                    MenuItem(
                      icon: Icons.person,
                      title: "Contact US",
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyAccountsPage()));
                      },
                    ),
                    MenuItem(
                      icon: Icons.account_box,
                      title: "About us",
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Aboutus()));
                      },
                    ),
                    MenuItem(
                      icon: Icons.shopping_basket,
                      title: "Services",
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyOrdersPage()));
                      },
                    ),
                    MenuItem(
                      icon: Icons.card_giftcard,
                      title: "FAQ",
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => FAQ()));
                      },
                    ),
                    Divider(
                      height: 10,
                      thickness: 0.5,
                      color: Colors.white.withOpacity(0.3),
                      indent: 25,
                      endIndent: 25,
                    ),

                    MenuItem(
                      icon: Icons.exit_to_app,
                      title: "Logout",
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => LoginScreen()));
                      },
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),

      ),
      body: (currentLocations != null)
//      (currentLocation != null)
          ? Stack(
              children: <Widget>[
                Container(child: _loadMap()),
                Positioned(
                    top: 55,
                    right: 15,
                    left: 15,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
//                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.search,
                              color: Colors.blue,
                            ),
                            onPressed: searchandNavigate,
                          ),
                          Expanded(
                              child: TextField(
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.go,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15),
                              hintText: "Search here",
                            ),
                            onChanged: (val) {
                              if (!mounted) return;
                              setState(() {
                                searchaddress = val;
                              });
                            },
//                            onTap: () => GooglePlacesAutocompleteWidget,
//                            onTap: () async {
//                              Prediction p = await PlacesAutocomplete.show(
//                                  context: context,
//                                  apiKey:
//                                      "AIzaSyBerIytX6hL8AicPKOWHG12YQOpRqv9fFE",
//                                  language: 'en',
//                                  components: [
//                                    Component(Component.country, 'eg')
//                                  ]);
//                              //searchAutoComplete();
//                            },
                          )),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: CircleAvatar(
                              child: Image.asset('images/car.png'),
                              radius: 20.0,
                              backgroundColor: Colors.orange[400],
                            ),
                          ),
                        ],
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 150, top: 620.0),
                  child: FloatingActionButton(
                    heroTag: 'text1',
                    onPressed:  _onMapTypeButtonPressed,
                    child: Icon(Icons.map),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 80, top: 620.0),
                  child: FloatingActionButton(
                    heroTag: 'text2',
                      onPressed: () => _addToList(),
//                        _onAddMarkerButtonPressed(LatLng(
//                            currentLocation.latitude,
//                            currentLocation.longitude));

                      backgroundColor: Colors.orange[600],
                      child: //Icon(Icons.add_location,size: 35.0 , color: Colors.black,),
                          Image.asset(
                        'images/marker.png',
                        width: 35.0,
                        color: Colors.black,
                      )),
                )
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

//  getUsersearchvalue() {
//    Geolocator().placemarkFromAddress(searchAddress).then((result) {
//      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
//          target:
//              LatLng(result[0].position.latitude, result[0].position.longitude),
//          zoom: 10.0)));
//    });
//  }

  void _onMapCreated(controller) {
    if (!mounted) return;
    setState(() {

    mapController = controller;
    });
  }

  void _onCameraMove(CameraPosition position) {
    _lastPosition = position.target;
  }

  searchandNavigate() {
    Geolocator().placemarkFromAddress(searchaddress).then((result) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target:
              LatLng(result[0].position.latitude, result[0].position.longitude),
          zoom: 9.0)));
    });
  }
}

//
//  _autoCompleteSearch() async{
//    Prediction p = await PlacesAutocomplete.show(
//        context: context,
//        apiKey: kGoogleApiKey,
//      components: [new Component(Component.country)]
//    )
//  }
//  void setSourceAndDestinationIcon() async{
//    sourceIcon = await BitmapDescriptor.fromAssetImage(
//        ImageConfiguration( devicePixelRatio: 2.5 ) ,
//        'images/carIcon.png'
//    );
//
//    destinationIcon = await BitmapDescriptor.defaultMarker;
//  }
//
