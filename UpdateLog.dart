import 'dart:async';

import 'package:app/Tools/ShowDialogTool.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UpdateLog extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _UpdateLog();
  }
}

class _UpdateLog extends State<UpdateLog>{

  List Data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(milliseconds: 500), (){
      ShowLoadingDialog(context);
      rootBundle.loadString('config/url.txt').then((url){
        url = '${url}/AppVersion/';
        Dio().get(url).then((response){
          Navigator.pop(context);
          setState(() {
            Data = response.data['data'];
          });
        }).catchError((err){
          Navigator.pop(context);
          ShowErrorDialog(context, '服务器请求错误：${err}，请稍后再试');
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('更新日志'),
      ),
      body: ListView.builder(itemBuilder: (context,index){
        return ListTile(
          title: Text('版本：${Data[index]['Version']}'),
          subtitle: Text(Data[index]['Content']),
        );
      },
      itemCount: Data.length,
      physics: BouncingScrollPhysics(),),
    );
  }
}