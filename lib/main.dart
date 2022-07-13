import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 16, 29, 46),
        systemNavigationBarColor: Color.fromARGB(255, 16, 29, 46)));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WebViewPage(),
    );
  }
}

class WebViewPage extends StatefulWidget {
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  bool isLoading = true;
  late WebViewController _controller;
  arrowBack() async {
    if (await _controller.canGoBack()) {
      await _controller.goBack();
    }
  }

  arrowForwad() async {
    if (await _controller.canGoForward()) {
      await _controller.goForward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          WebView(
            initialUrl: 'https://jow.plus/live-meta/jow-charki',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller = webViewController;
            },
            onPageFinished: (String url) {
              setState(() {
                isLoading = false;
              });
              //hide you progressbar here
            },
          ),
          isLoading
              ? Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Color.fromARGB(255, 240, 243, 34)),
                    ),
                  ),
                  backgroundColor: Color.fromARGB(255, 16, 29, 0),
                ) // this is the main reason of transparency at next screen. I am ignoring rest implementation but what i have achieved is you can see.

              : Stack()
        ],
      ),
    );
    ;
  }
}
