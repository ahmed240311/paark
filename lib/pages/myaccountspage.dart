import 'package:flutter/material.dart';


class MyAccountsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _myaccount();
  }
}

//margin: const EdgeInsets.only(left: 130.0,top: 70),

class _myaccount extends State<MyAccountsPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          "Contact US",
          style: TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: new Container(
        margin: const EdgeInsets.only(left: 80.0, top: 100),
        child: Column(
          children: <Widget>[
            // Image.asset("imgeee/contact.jpg",width: 150,height: 150,),

            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage("images/contact.jpg"),
            ),

            SizedBox(
              height: 30,
            ),
            Text(
              "shibin elkom,almnofia,egypt",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w800),
            ),
            Text(
              "+2000000000",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w800),
            ),
            Text(
              "info@erkenly.com",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }
}
