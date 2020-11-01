import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Aboutus extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _myabout();
  }
}

class _myabout extends State<Aboutus> {
  Future<void> _launched;
  String phone = '';
  String _launchurl = "https://www.google.com";

  Future<void> _Instagram(String url) async {
    if (await canLaunch(url)) {
      final bool nativeAppLaunchSucceeded = await launch(
        url,
        forceSafariVC: false,
        universalLinksOnly: true,
      );
      if (!nativeAppLaunchSucceeded) {
        await launch(
          url,
          forceSafariVC: true,
        );
      }
    }
  }

  Future<void> _fasebook(String url) async {
    if (await canLaunch(url)) {
      final bool nativeAppLaunchSucceeded = await launch(
        url,
        forceSafariVC: false,
        universalLinksOnly: true,
      );
      if (!nativeAppLaunchSucceeded) {
        await launch(
          url,
          forceSafariVC: true,
        );
      }
    }
  }

  Future<void> _twitter(String url) async {
    if (await canLaunch(url)) {
      final bool nativeAppLaunchSucceeded = await launch(
        url,
        forceSafariVC: false,
        universalLinksOnly: true,
      );
      if (!nativeAppLaunchSucceeded) {
        await launch(
          url,
          forceSafariVC: true,
        );
      }
    }
  }

  Future<void> _youtube(String url) async {
    if (await canLaunch(url)) {
      final bool nativeAppLaunchSucceeded = await launch(
        url,
        forceSafariVC: false,
        universalLinksOnly: true,
      );
      if (!nativeAppLaunchSucceeded) {
        await launch(
          url,
          forceSafariVC: true,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          "About Us",
          style: TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: new Container(
        margin: const EdgeInsets.only(left: 50.0, top: 50, right: 50),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage("images/aboutuss.jpg"),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Erkenly is the best app for parking, Now you can know where you can parking,only use erkenly app",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w800),
            ),
            Icon(
              Icons.favorite,
              color: Colors.pink,
              size: 24.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
            Row(

              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(

                  onTap: () {
                    _fasebook("https://www.facebook.com/");
                  },

                  child: Image.asset(

                    "images/fasebook.png",
                    width: 50,
                    height: 50,
                  ),
                ),

                SizedBox(
                  width: 63,
                  height: 60,
                ),

                InkWell(
                    onTap: () {
                      _twitter("https://twitter.com/login?lang=ar");
                    },
                    child: Image.asset(
                      "images/twitter.png",
                      width: 50,
                      height: 50,
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 120,
                ),
                InkWell(
                    onTap: () {
                      _Instagram("https://www.instagram.com/arab99culture/");
                    },
                    child: Image.asset(
                      "images/Instagram.png",
                      width: 50,
                      height: 50,
                    )),
                SizedBox(
                  width: 60,
                ),
                InkWell(
                  onTap: () {
                    _youtube("https://www.youtube.com");
                  },
                  child: Image.asset(
                    "images/youtube.png",
                    width: 62,
                    height: 100,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
