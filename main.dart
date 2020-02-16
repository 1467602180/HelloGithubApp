import 'package:app/GitHubWebView.dart';
import 'package:app/Home.dart';
import 'package:app/RealseList.dart';
import 'package:app/RealseView.dart';
import 'package:app/Run.dart';
import 'package:app/Tools/SetStatusColorTool.dart';
import 'package:flutter/material.dart';

import 'ProjectClassList.dart';
import 'ProjectClassView.dart';
import 'UpdateLog.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SetStatusColor();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: Colors.white,
          textTheme: TextTheme(
            title: TextStyle(
              color: Colors.black,
              shadows: [Shadow(color: Colors.grey,offset: Offset(3, 3))],
              fontSize: 26,
              fontFamily: 'Love',
              fontWeight: FontWeight.bold
            )
          ),
          iconTheme: IconThemeData(
            color: Colors.black
          )
        ),
        scaffoldBackgroundColor: Colors.white,
        highlightColor: Color(0x3388d4c2),
        splashColor: Color(0x9988d4c2)
      ),
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        '/':(context)=>Run(),
        '/Home':(context)=>Home(),
        '/RealseList':(context)=>RealseList(),
        '/RealseView':(context)=>RealseView(),
        '/GitHubWebView':(context)=>GitHubWebView(),
        '/ProjectClassList':(context)=>ProjectClassList(),
        '/ProjectClassView':(context)=>ProjectClassView(),
        '/UpdateLog':(context)=>UpdateLog()
      },
    );
  }
}