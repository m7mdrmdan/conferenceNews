import 'package:flutter/material.dart';

class NewsView extends StatefulWidget {
      final String imagepath;
      final String title;
      final String description;
      NewsView({this.imagepath , this.title, this.description});
  @override
  _NewsViewState createState() => _NewsViewState();
}
class _NewsViewState extends State<NewsView> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF7A9BEE),
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            //   Navigator.of(context).push(MaterialPageRoute(
            //   builder: (context) => AppNews()
            // ));
            },
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text('التفاصيل ',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20.0,
                  color: Colors.white)
                ),
          centerTitle: true,
        ),      
      body:new Directionality(textDirection: TextDirection.rtl,
      child:Container(
        child : ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(45.0),
                topLeft: Radius.circular(45.0),),
            ),
            child: ListView(
              primary: false,
              padding: EdgeInsets.only(top: 0.0),
              children: <Widget>[
                   Hero(
                    tag: widget.imagepath,
                    child: Container(
                      // margin: EdgeInsets.only(top: 100.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(45.0),
                              topLeft: Radius.circular(45.0),
                              ),
                            image: DecorationImage(
                                image: NetworkImage(widget.imagepath),
                                fit: BoxFit.fill,
                                )
                                ),
                        height: MediaQuery.of(context).size.height * 0.30,
                        // width: 200.0
                    )
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    margin: EdgeInsets.all(15),
                    child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Text(widget.title,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        SizedBox(height: 10.0),
                        Text(widget.description,
                          style: TextStyle(
                            // fontFamily: 'Montserrat',
                            fontSize: 25.0,
                            color: Colors.grey
                          )
                        )
                      ]
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
      ) ,
    ),
    );
  }

}
