import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'main.dart';
import 'news-view.dart';
import 'package:http/http.dart' as http;

import 'newsmodal.dart';

class AppNews extends StatefulWidget {
  List<Newsmodal> allNews = [];
  bool _isLoading = false;
  // AppNews({this.allNews}); new Newsmodal(description: '1',details: '2',id: '3',image: '4',title: 'title')

  @override
  _AppNewsState createState() => _AppNewsState();
}

class _AppNewsState extends State<AppNews> {
  @override
  initState() {
    fetchNews();
    super.initState();

  }

  void fetchNews() async {
    widget._isLoading = true;
    await http
        .get('https://sportsapp-75415.firebaseio.com/appNews.json')
        .then((http.Response response) {
      widget._isLoading = false;
      final List<Newsmodal> fetchedNewsList = [];
      final Map<String, dynamic> newsListData = json.decode(response.body);
      newsListData.forEach((String productId, dynamic productData) {
        final Newsmodal newsData = Newsmodal(
          id: productId,
          title: productData['title'],
          description: productData['description'],
          image: productData['image'],
          details: productData['details'],
        );
        fetchedNewsList.add(newsData);
      });
      setState(() {
        widget.allNews = fetchedNewsList.reversed.toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (widget._isLoading) {
      content = Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(45.0),
              topLeft: Radius.circular(45.0),
            ),
          ),
          child: Center(
              child: Container(
                  height: 120.0,
                  width: 120.0,
                  child: CircularProgressIndicator(
                    backgroundColor: Color(0xFF21BFBD),
                    strokeWidth: 10.0,
                  ))));
    } else {
      content = Container(
        child: ListView(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(45.0),
                  topLeft: Radius.circular(45.0),
                ),
              ),
              child: ListView(
                primary: false,
                padding: EdgeInsets.only(left: 15.0, right: 10.0),
                children: <Widget>[
                  // Padding(
                  // padding: EdgeInsets.only(top: 15.0),
                  Container(
                      height: MediaQuery.of(context).size.height - 100.0,
                      child: ListView(
                          children: widget.allNews
                              .map(
                                (element) => _buildNewsItem(
                                    element.image,
                                    element.title,
                                    element.description,
                                    element.details),
                              )
                              .toList()))
                  // ),
                ],
              ),
            )
          ],
        ),
      );
    }
    return Scaffold(
      backgroundColor: Color(0xFF7A9BEE),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            // Navigator.of(context).push(MaterialPageRoute(
            //   builder: (context) => MyApp()
            // ));
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text('أخبار المؤتمر',
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 20.0,
                color: Colors.white)),
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
        child: content,
      ),
    );
  }

  Widget _buildNewsItem(
      String imgPath, String title, String desc, String details) {
    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NewsView(
                  imagepath: imgPath, title: title, description: details),
            ));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Row(children: [
                Card(
                  child: Image(
                    image: NetworkImage(imgPath),
                    fit: BoxFit.cover,
                    height: 80.0,
                    width: 80.0)),
                SizedBox(width: 10.0),
                Container (
                //  padding: const EdgeInsets.all(16.0),
                 width: MediaQuery.of(context).size.width*0.6,
                 child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold)),
                          Text(details,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                           fontFamily: 'Montserrat',
                           fontSize: 15.0,
                           color: Colors.grey))
                ]))
              ])),
            ],
          ),
        ));
  }
}
