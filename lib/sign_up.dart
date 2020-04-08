import 'package:flutter/material.dart';
import 'package:sport/myweb-view.dart';

class SignUpPage extends StatefulWidget {
  final heroTag;
  final title;

  SignUpPage({this.heroTag, this.title});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var selectedCard = 'WEIGHT';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF7A9BEE),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text('تسجيل المشاركه',
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
          child: ListView(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height - 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(45.0),
                    topLeft: Radius.circular(45.0),
                  ),
                ),
                child: ListView(
                  primary: false,
                  // padding: EdgeInsets.only(left: 25.0, right: 20.0),
                  // child: Column(
                  children: <Widget>[
                    Hero(
                        tag: widget.heroTag,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(45.0),
                                topLeft: Radius.circular(45.0),
                              ),
                              image: DecorationImage(
                                  image: AssetImage(widget.heroTag),
                                  fit: BoxFit.cover)),
                          height: MediaQuery.of(context).size.height * 0.40,
                          // width: 200.0
                        )),
                    SizedBox(height: 20.0),
                    Container(
                        height: 150.0,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            _buildInfoCard('مشاركه (حضور او اونلاين)',
                                'assets/1-1.png', 0),
                            SizedBox(width: 10.0),
                            _buildInfoCard(
                                'مشاركة ببحث فردي', 'assets/2.png', 1),
                            SizedBox(width: 10.0),
                            _buildInfoCard(
                                'مشاركة ببحث زوجي ', 'assets/2-2.png', 2),
                            SizedBox(width: 10.0),
                            _buildInfoCard(
                                'مشاركة ببحث جماعي', 'assets/3-3.png', 3)
                          ],
                        )),
                  ],
                  // )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String cardTitle, String imgPath, int count) {
    return InkWell(
        onTap: () {
          selectCard(cardTitle, count);
        },
        child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color:
                  cardTitle == selectedCard ? Color(0xFFFFBBEE) : Colors.white,
              border: Border.all(
                  color: cardTitle == selectedCard
                      ? Colors.transparent
                      : Colors.grey.withOpacity(0.3),
                  style: BorderStyle.solid,
                  width: .75),
            ),
            height: 250.0,
            width: 100.0,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 3.0, left: 5.0, right: 5.0),
                    child: Container(
                        // fit: BoxFit.cover,: BoxFit.cover,width: MediaQuery.of(context).size.width*0.9,
                        child: Text(cardTitle,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 13.0,
                                color: Color(0xFF7A9BEE),
                                fontWeight: FontWeight.bold))),
                  ),
                  Card(
                    // height: MediaQuery.of(context).size.height*0.06,
                    child: Image(
                    image: AssetImage(imgPath),
                    fit: BoxFit.fill,
                    height: 70.0,
                    // width: 70.0
                  )),
                ])));
  }

  selectCard(cardTitle, count) {
    setState(() {
      selectedCard = cardTitle;
    });
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => count == 0
          ? WebViewContainer(
              title: cardTitle,
              url:
                  'https://arabwomensports.com/%d8%aa%d8%b3%d8%ac%d9%8a%d9%84-%d8%a7%d9%84%d8%ad%d8%b6%d9%88%d8%b1/')
          : count == 1
              ? WebViewContainer(
                  title: cardTitle,
                  url:
                      'https://arabwomensports.com/%d8%aa%d8%b3%d8%ac%d9%8a%d9%84-%d8%a8%d8%a8%d8%ad%d8%ab-%d9%81%d8%b1%d8%af%d9%8a/')
              : count == 2
                  ? WebViewContainer(
                      title: cardTitle,
                      url:
                          'https://arabwomensports.com/%d8%aa%d8%b3%d8%ac%d9%8a%d9%84-%d8%a8%d8%a8%d8%ad%d8%ab-%d8%b2%d9%88%d8%ac%d9%8a/')
                  : count == 3
                      ? WebViewContainer(
                          title: cardTitle,
                          url:
                              'https://arabwomensports.com/%d8%aa%d8%b3%d8%ac%d9%8a%d9%84-%d8%a8%d8%a8%d8%ad%d8%ab-%d8%ac%d9%85%d8%a7%d8%b9%d9%8a/')
                      : null,
    ));
  }
}
