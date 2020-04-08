import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:sport/myweb-view.dart';
import 'contact-us.dart';
import 'newsmodal.dart';
import 'sign_up.dart';
import 'app-news.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Newsmodal> messages = [];
  BuildContext scaffoldContext;
  bool _isConfigured = false;


    @override
  initState() {
    super.initState();
    if (!_isConfigured) {
      _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        final notification = message['notification'];
        // createSnackBar(notification['title']);
        showFloatingFlushbar(scaffoldContext,notification['title'],notification['body']);
        // setState(() {
        //   // createSnackBar('Mohamed ramadan kamal');
        //   print("onMessage set state: $message");
        //   // messages.add(Message(
        //   //     title: notification['title'], body: notification['body']));_onBackgroundMessage
        // });
      },
      onLaunch: (Map<String, dynamic> message) async {
                    Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AppNews()
            ));
        print("onLaunch: $message");

        final notification = message['data'];
        setState(() {
          // messages.add(Message(
          //   title: '${notification['title']}',
          //   body: '${notification['body']}',
          // ));
        });
      },
      onResume: (Map<String, dynamic> message) async {
                    Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AppNews()
            ));
        print("onResume: $message");
      },
    );
      _isConfigured = true;
        _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    }
  }
 
    void showFloatingFlushbar(BuildContext context,String title , String body) {
    Flushbar(
      padding: EdgeInsets.all(10),
      borderRadius: 8,
      backgroundGradient: LinearGradient(
        colors: [Color(0xFF7A9BEE), Color(0xFF7A9BEE)],
        stops: [0.6, 1],
      ),
      boxShadows: [
        BoxShadow(
          color: Colors.black45,
          offset: Offset(3, 3),
          blurRadius: 3,
        ),
      ],
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      // title: title,
      titleText:new Directionality(
      textDirection: TextDirection.rtl,
      child: Text(title),),
      // message: body,
      messageText:new Directionality(
      textDirection: TextDirection.rtl,
      child: Text(body),),
      onTap:(test){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AppNews()
            ));
        },
      duration: const Duration(seconds: 4),
    )..show(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //       appBar: AppBar(
        //   title: Text('Home Screen'),
        // ),
      backgroundColor: Color(0xFF21BFBD),
      body:new Builder(builder: (BuildContext context) {                                                           
      scaffoldContext = context; 
      return new Directionality(
      textDirection: TextDirection.rtl,
      child:Container(
        child : ListView(
        children: <Widget>[
          SizedBox(height: 25.0),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Row(
              children: <Widget>[
                SizedBox(width: 10.0),
                Container(
                  width: MediaQuery.of(context).size.width*0.8,
                child:Text('مؤتمر رياضة المرأة العربية',
                textAlign: TextAlign.center,
                // overflow: TextOverflow.ellipsis,
                // softWrap: false,
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 27.0))),
              ],
            ),
          ),
          SizedBox(height: 40.0),
          Container(
            height: MediaQuery.of(context).size.height - 150.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(75.0)),
            ),
            child: ListView(
              primary: false,
              padding: EdgeInsets.only(left: 25.0, right: 20.0),
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 35.0),
                    child: Container(
                        height: MediaQuery.of(context).size.height - 100.0,
                        child: ListView(children: [
                          _buildMenuItem('assets/news.png', 'أخبار المؤتمر','news'),
                          _buildMenuItem('assets/sign.png', 'تسجيل المشاركه','singup'),
                          // _buildFoodItem('assets/share.png', 'النشر العملي','share'),
                          _buildMenuItem('assets/womanreg.jpg', 'جائزة افضل معلمة','woman'),
                          _buildMenuItem('assets/contact-us.png', 'تواصل معنا','contact')
                        ]))),
             
              ],
            ),
          ),
          // SizedBox(height: 40.0),
          // SnackBarPage(),
        ],
      ),
      ) ,
    );
      })

    );
  }

  Widget _buildMenuItem(String imgPath, String title,String tab) {
return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => 
              tab == 'news'?AppNews():
              tab == 'singup'? SignUpPage(heroTag:'assets/signup.jpg', title: title):
              tab == 'contact'?ContactUS(title:title):
              tab == 'woman'?WebViewContainer(title: title,url: 'https://arabwomensports.com/3697-2/'):
              // tab == 'share'?WebViewContainer(title: title,url: 'https://arabwomensports.com/%d8%a7%d9%84%d9%86%d8%b4%d8%b1-%d8%a7%d9%84%d8%b9%d9%84%d9%85%d9%8a/'):
              null,
            ));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Row(
                  children: [
                    Hero(
                      tag: imgPath,
                      child: Image(
                        image: AssetImage(imgPath),
                        fit: BoxFit.cover,
                        height: 70.0,
                        width: 70.0
                      )
                    ),
                    SizedBox(width: 20.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Text(
                          title,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold
                          )
                        ),
                      ]
                    )
                  ]
                )
              ),
            ],
          )
        ));
  }
}



