import 'package:flutter/material.dart';

class MyOrdersPage extends StatefulWidget  {
  @override
  State<StatefulWidget> createState() {
    return new _myservices();
  }
}

class _myservices extends State<MyOrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Services",
          style: TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: new Container(
        margin: const EdgeInsets.only(left: 50.0, top: 25, right: 50),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  " What we deliver",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w800),
                ),
              ],
            ),
            Divider(
              height: 44,
              thickness: 1.0,
              color: Colors.deepOrange.withOpacity(1.0),
              indent: 32,
              endIndent: 32,
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Image.asset(
                    "images/Caar.png",
                    width: 50,
                    height: 50,
                  ),
                  ListTile(
                    title: Text(
                      "EASY PARKING",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w800),
                    ),
                    subtitle: Text(
                      "Now you can easy find more & more places around your location to parking,only use Erkenly app",
                      style: TextStyle(
                        color: Color(0xFF1BB5FD),
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Image.asset(
                    "images/offerpoint.png",
                    width: 50,
                    height: 50,
                  ),
                  ListTile(
                    title: Text(
                      "OFFERS WITH POINTS",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w800),
                    ),
                    subtitle: Text(
                      "When you use erkenly app you will get more points,you can easy use them in offers",
                      style: TextStyle(
                        color: Color(0xFF1BB5FD),
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Image.asset(
                    "images/trafficjam.jpg",
                    width: 50,
                    height: 50,
                  ),
                  ListTile(
                    title: Text(
                      "TRAFFIC JAM",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w800),
                    ),
                    subtitle: Text(
                      "Now, there is no one forced to park his car in a incompatible place",
                      style: TextStyle(
                        color: Color(0xFF1BB5FD),
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
