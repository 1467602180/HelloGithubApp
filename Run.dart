import 'dart:async';

import 'package:app/Tools/SetStatusColorTool.dart';
import 'package:app/Tools/ShowDialogTool.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:dio/dio.dart';

class Run extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Run();
  }
}

class _Run extends State<Run>{

  void GetIndexData()async{
    rootBundle.loadString('config/url.txt').then((url){
      url = '${url}/Index/';
      Dio().get(url).then((response){
        Navigator.pushNamedAndRemoveUntil(context, '/Home', (route) => false,arguments: {'IndexData':response.data});
      }).catchError((err){
        ShowErrorDialog(context, '服务器请求错误：${err}，请稍后再试');
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetIndexData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SetStatusColor();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Hello Github',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              fontFamily: 'Love'
            ),),
            Text('兴趣是最好的老师',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),),
            SpinKitCircle(
              color: Colors.black,
              size: 50.0,
            )
          ],
        ),
      ),
    );
  }
}