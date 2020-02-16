import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

void GetUpdate(context)async{
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version = packageInfo.version;
  rootBundle.loadString('config/url.txt').then((url){
    var urls = '${url}/AppVersion/';
    Dio().get(urls).then((response){
      if(response.data['data'][0]['Version']>double.parse(version)){
        showDialog(context: context,builder: (_){
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
            title: Text('更新提示'),
            content: Text('版本：${response.data['data'][0]['Version']}\n更新日志：\n${response.data['data'][0]['Content']}'),
            actions: <Widget>[
              FlatButton(onPressed: (){
                launch('${url}/Apk/?id=${response.data['data'][0]['id']}');
              }, child: Text('前往下载'))
            ],
          );
        });
      }
    });
  });
}