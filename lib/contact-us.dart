
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'main.dart';


class ContactUS extends StatelessWidget {
    final title;

  ContactUS({this.title});

  @override
  Widget build(BuildContext context) {
        return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    Future<void> _launched;
    String _phone = '';

    Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
    Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }
    
    Future<void> _openMap() async {
    const latitude = 29.977127;  const longitude = 31.282752;
      if (!Platform.isIOS) {
    const url = 'https://maps.app.goo.gl/g4jNwSAbcS5F8k1g7';
    const url2 = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(url2)) {
      await launch(url2);
      print("object");
    } else {
      throw 'Could not launch $url2';
    }
  }else {
     const urlAppleMaps = 'https://maps.apple.com/?q=$latitude,$longitude';
     if (await canLaunch(urlAppleMaps)) {
  await launch(urlAppleMaps);
} else {
  throw 'Could not launch $urlAppleMaps';
}

  }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color(0xFF7A9BEE),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MyApp()
            ));
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text('تواصل معنا',
            style: TextStyle(
                fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.white)),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () {},
            color: Colors.white,
          )
        ],
      ),
      body: new Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
        child : ListView(
        children: <Widget>[
          SizedBox(height: 25.0),
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(45.0),topLeft: Radius.circular(45.0)),
            ),
            child: ListView(
              primary: false,
              padding: EdgeInsets.only(left: 25.0, right: 20.0),
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 25.0),
                    child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListView(children: [
                          _buildContactItem('assets/plate1.png',1, 'التواصل عبر الهاتف', '00966536243047 – 00201004474574'),
                          SizedBox(height: 10.0),
                          _buildContactItem('assets/mail2.png',2, 'تواصل عبر البريد', 'info@arabwomensports.com'),
                          SizedBox(height: 10.0),
                          _buildContactItem('assets/location.png',3, 'جمهورية مصر العربية', 'فندق الماسة مدينة نصر - القاهرة'),
                          // SizedBox(height: 10.0),
                          // _buildContactItem('assets/facebook.png',4, 'تواصل عبر البريد', 'https://www.facebook.com/arabwomensports/'),
                        ]))),
             FutureBuilder<void>(future: _launched, builder: _launchStatus),
              ],
            ),
          ),
          
        ],
      ),
      ) ,
      ),
    );
  }

  Widget _buildContactItem(String imgPath,int x, String name, String data) {
    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: InkWell(
          onTap: () {
              // _openMap();
              setState(() {
                _phone=data;
                x==1? _launched = _makePhoneCall('tel:$_phone'):
                _openMap();
                });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Row(
                  children: [
// call - contact_phone - contact_mail  -  computer  - my_location
                    x == 1 ?Icon(
                      Icons.call,
                      color: Colors.greenAccent,
                      size: 30.0,
                    ): Hero(
                      tag: imgPath,
                      child: Image(
                        image: AssetImage(imgPath),
                        fit: BoxFit.cover,
                        height: 40.0,
                        width: 40.0
                      )
                    ),
                    SizedBox(width: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Text(
                          name,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        Text(
                          data,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 15.0,
                            color: Colors.grey
                          )
                        )
                      ]
                    )
                  ]
                )
              ),
            ],
          )
        ));
  }

    static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}

