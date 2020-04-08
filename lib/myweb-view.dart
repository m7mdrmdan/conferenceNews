import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class _WebViewContainerState extends State<WebViewContainer> {
  var _url;
  final _key = UniqueKey();
  _WebViewContainerState(this._url);
  num _stackToView = 1;

  void _startLoad(String value) {
    setState(() {
      _stackToView = 1;
    });
  }

  void _endLoad(String value) {
    setState(() {
      _stackToView = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF7A9BEE),
          title: Text(widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 27.0,
                  color: Colors.white)),
          centerTitle: true,
        ),
        body: IndexedStack(
          index: _stackToView,
          children: [
            Column(
              children: <Widget>[
                Expanded(
                    child: WebView(
                  key: _key,
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: _url,
                  onPageStarted: _startLoad,
                  onPageFinished: _endLoad,
                )),
              ],
            ),
            Container(
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
                        ))))
          ],
        ));
  }
}

class WebViewContainer extends StatefulWidget {
  final url;
  final String title;
  WebViewContainer({this.url, this.title});
  @override
  createState() => _WebViewContainerState(this.url);
}
