import 'dart:async';

import 'package:app/Tools/ShowDialogTool.dart';
import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Tools/SetStatusColorTool.dart';

class ProjectClassView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProjectClassView();
  }
}

class _ProjectClassView extends State<ProjectClassView>{

  Map ProjectClassData = {};
  int Count = 0;
  ScrollController scrollController = ScrollController();

  void _onLoading(index) async{
    ShowLoadingDialog(context);
    rootBundle.loadString('config/url.txt').then((url){
      if(Map.from(ModalRoute.of(context).settings.arguments)['ProjectClass']=='C# 项目'){
        url = '${url}/ProjectClass/?Class=C%23%20项目&Page=${index}';
      }else if(Map.from(ModalRoute.of(context).settings.arguments)['ProjectClass']=='C++ 项目'){
        url = '${url}/ProjectClass/?Class=C%2B%2B%20项目&Page=${index}';
      }else{
        url = '${url}/ProjectClass/?Class=${Map.from(ModalRoute.of(context).settings.arguments)['ProjectClass']}&Page=${index}';
      }
      Dio().get(url).then((response){
        Navigator.pop(context);
        ProjectClassData = response.data;
        setState(() {
          Count=ProjectClassData['Title'].length;
        });
        scrollController.jumpTo(0);
      }).catchError((err){
        Navigator.pop(context);
        ShowErrorDialog(context, '服务器请求错误：${err}，请稍后再试');
      });
    });
  }

  void GetData()async{
    ShowLoadingDialog(context);
    rootBundle.loadString('config/url.txt').then((url){
      if(Map.from(ModalRoute.of(context).settings.arguments)['ProjectClass']=='C# 项目'){
        url = '${url}/ProjectClass/?Class=C%23%20项目&Page=1';
      }else if(Map.from(ModalRoute.of(context).settings.arguments)['ProjectClass']=='C++ 项目'){
        url = '${url}/ProjectClass/?Class=C%2B%2B%20项目&Page=1';
      }else{
        url = '${url}/ProjectClass/?Class=${Map.from(ModalRoute.of(context).settings.arguments)['ProjectClass']}&Page=1';
      }
      Dio().get(url).then((response){
        Navigator.pop(context);
        ProjectClassData = response.data;
        setState(() {
          Count=ProjectClassData['Title'].length;
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
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SetStatusColor();
    return Scaffold(
      appBar: AppBar(
        title: Text(Map.from(ModalRoute.of(context).settings.arguments)['ProjectClass']),
      ),
      body: Flex(direction: Axis.vertical,
        children: <Widget>[
          Expanded(child: ListView.builder(itemBuilder: (context,index){
            return ListTile(
              title: Text('${index+1}、${ProjectClassData['Title'][index]}'),
              subtitle: Padding(padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(ProjectClassData['Content'][index]),
                    Text('Star：${ProjectClassData['Star'][index]} Watch：${ProjectClassData['Watch'][index]} Fork：${ProjectClassData['Fork'][index]}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                    Offstage(
                      offstage:ProjectClassData['Image'][index].length==0?true:false,
                      child: ExtendedImage.network(
                        ProjectClassData['Image'][index].length==0?'':ProjectClassData['Image'][index][0],
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
                Navigator.pushNamed(context, '/GitHubWebView',arguments: {'Title':ProjectClassData['Title'][index],'Href':ProjectClassData['Href'][index]});
              },
            );
          },
              itemCount: Count,
              physics: BouncingScrollPhysics(),
              controller: scrollController),flex: 9,),
          Expanded(child: Flex(direction: Axis.horizontal,
          children: <Widget>[
            Expanded(child: Center(
              child: Offstage(
                offstage: ProjectClassData['CanUp']==null?true:!ProjectClassData['CanUp'],
                child: RaisedButton(onPressed: (){
                  _onLoading(ProjectClassData['UpNumber']);
                },
                child: Text('上一页',style: TextStyle(color: Colors.white),),
                color: Colors.black,),
              ),
            )),
            Expanded(child: Center(
              child: Offstage(
                offstage: ProjectClassData['CanDown']==null?true:!ProjectClassData['CanDown'],
                child: RaisedButton(
                  onPressed: (){
                    _onLoading(ProjectClassData['DownNumber']);
                  },
                  child: Text('下一页',style: TextStyle(color: Colors.white),),
                  color: Colors.black,
                ),
              ),
            ))
          ],),
            flex: 1,)
        ],),
    );
  }
}