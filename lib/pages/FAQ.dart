import 'package:flutter/material.dart';

class FAQ extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _myfaq();
  }
}

class _myfaq extends State<FAQ> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "FAQ",
          style: TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: new Container(
        margin: const EdgeInsets.only(left: 50.0, top: 25, right: 50),
        child: Column(
          children: <Widget>[
            Image.asset(
              "images/faq.png",
              width: 90,
              height: 90,
            ),
            Text(
              "Have question about us?",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w800),
            ),
            Divider(
              height: 44,
              thickness: 1.0,
              color: Colors.deepOrange.withOpacity(1.0),
              indent: 32,
              endIndent: 32,
            ),
            ListTile(
              title: Text(
                "How You Can Know The Parking Places?",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              ),
              subtitle: Text(
                "you can easy use the app map and share your location to view the parking places around you.",
                style: TextStyle(
                  color: Color(0xFF1BB5FD),
                  fontSize: 15,
                ),
              ),
            ),
            ListTile(
              title: Text(
                "What Is Points?",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              ),
              subtitle: Text(
                "you can now get 1 point after parking with Erkenly app.",
                style: TextStyle(
                  color: Color(0xFF1BB5FD),
                  fontSize: 15,
                ),
              ),
            ),
            ListTile(
              title: Text(
                "What Is Offers?",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              ),
              subtitle: Text(
                "you can get more discounts for few of points.",
                style: TextStyle(
                  color: Color(0xFF1BB5FD),
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
