import 'dart:async';

import 'package:app/Tools/ShowDialogTool.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:extended_image/extended_image.dart';

import 'Tools/SetStatusColorTool.dart';

class RealseView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RealseView();
  }
}

class _RealseView extends State<RealseView>{

  Map RealseData = {};

  void GetData()async{
    ShowLoadingDialog(context);
    rootBundle.loadString('config/url.txt').then((url){
      url = '${url}/RealseNumber/?Number=${Map.from(ModalRoute.of(context).settings.arguments)['RealseNumber']}';
      Dio().get(url).then((response){
        Navigator.pop(context);
        setState(() {
          RealseData = response.data;
        });
      }).catchError((err){
        Navigator.pop(context);
        ShowErrorDialog(context, '服务器请求错误：${err}，请稍后再试');
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(milliseconds: 500), (){
      GetData();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SetStatusColor();
    return Scaffold(
      appBar: AppBar(
        title: Text('第${Map.from(ModalRoute.of(context).settings.arguments)['RealseNumber']}期'),
      ),
      body: ListView.builder(itemBuilder: (context,index){
        return ListTile(
          title: Text('${index+1}、${RealseData['Title'][index]}'),
          subtitle: Padding(padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(RealseData['Content'][index]),
              Text('Star：${RealseData['Star'][index]} Watch：${RealseData['Watch'][index]} Fork：${RealseData['Fork'][index]}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
              Offstage(
                offstage:RealseData['Image'][index].length==0?true:false,
                child: ExtendedImage.network(
                  RealseData['Image'][index].length==0?'':RealseData['Image'][index][0],
                  width: MediaQuery.of(context).size.width*0.8,
                  height: 150,
                  fit: BoxFit.fill,
                  cache: true,
                  border: Border.all(color: Colors.red, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  //cancelToken: cancellationToken,
                ),
              )
            ],
          ),),
          onTap: (){
            Navigator.pushNamed(context, '/GitHubWebView',arguments: {'Title':RealseData['Title'][index],'Href':RealseData['Href'][index]});
          },
        );
      },
      itemCount: RealseData['Title']==null?0:RealseData['Title'].length,
      physics: BouncingScrollPhysics(),),
    );
  }
}