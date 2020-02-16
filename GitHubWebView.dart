import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'Tools/SetStatusColorTool.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GitHubWebView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GitHubWebView();
  }
}

class _GitHubWebView extends State<GitHubWebView>{

  WebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SetStatusColor();
    return Scaffold(
      appBar: AppBar(
        title: Text(Map.from(ModalRoute.of(context).settings.arguments)['Title']),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add_to_home_screen), onPressed: (){
            launch(Map.from(ModalRoute.of(context).settings.arguments)['Href']);
          })
        ],
      ),
      body: WillPopScope(
        onWillPop: ()async{
          webViewController.canGoBack().then((can){
            if(can){
              webViewController.goBack();
              return false;
            }else{
              Navigator.pop(context);
              return true;
            }
          });
          return false;
        },
        child: WebView(
          initialUrl: Map.from(ModalRoute.of(context).settings.arguments)['Href'],
          onPageStarted: (_){
            Fluttertoast.showToast(
                msg: '即将前往链接：${_.toString()}',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.grey,
                textColor: Colors.white,
                fontSize: 16.0
            );
          },
          onWebViewCreated: (_){
            Fluttertoast.showToast(
                msg: '浏览器初始化中...',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.grey,
                textColor: Colors.white,
                fontSize: 16.0
            );
            webViewController = _;
          },
          javascriptMode: JavascriptMode.unrestricted,
          userAgent: 'Mozilla/5.0 (Linux; Android 5.0; SM-G900P Build/LRX21T) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.100 Mobile Safari/537.36'
        ),
      ),
    );
  }
}