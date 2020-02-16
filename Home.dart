import 'dart:async';

import 'package:app/Tools/SetStatusColorTool.dart';
import 'package:app/Tools/UpdateTool.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Home();
  }
}

class _Home extends State<Home>{

  ColumnView(){
    List<Widget> list = [];
    for(var i=0;i<Map.from(ModalRoute.of(context).settings.arguments)['IndexData']['Title'].length;i++){
      var a = Container(
        margin: EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
              margin: EdgeInsets.only(bottom: 8),
              alignment: Alignment.centerLeft,
              child: Text(Map.from(ModalRoute.of(context).settings.arguments)['IndexData']['Title'][i],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),),
            ),
            Text(Map.from(ModalRoute.of(context).settings.arguments)['IndexData']['Content'][i])
          ],
        ),
      );
      list.add(a);
    }
    return list;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(milliseconds: 500), (){
      GetUpdate(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SetStatusColor();
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.perm_device_information), onPressed: (){
            Navigator.pushNamed(context, '/UpdateLog');
          })
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
//            头部
            Container(
              height: 200,
              child: DefaultTextStyle(
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                        width: MediaQuery.of(context).size.width/3,
                        margin: EdgeInsets.symmetric(vertical: 24,horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          color: Color(0xff519251),
                          boxShadow: [BoxShadow(color: Color(0x99519251),offset: Offset(0, 3))]
                        ),
                        child: Flex(direction: Axis.vertical,children: <Widget>[
                          Expanded(child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text('期刊'),
                          ),
                          flex: 1,),
                          Expanded(child: Container(
                            alignment: Alignment.center,
                            child: Text('已发布${Map.from(ModalRoute.of(context).settings.arguments)['IndexData']['RealseNumber'].length}期'),
                          ),
                          flex: 3,)
                        ],),
                      ),
                      onTap: (){
                        Navigator.pushNamed(context, '/RealseList',arguments: {'RealseData':Map.from(ModalRoute.of(context).settings.arguments)['IndexData']['RealseNumber']});
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        width: MediaQuery.of(context).size.width/3,
                        margin: EdgeInsets.symmetric(vertical: 24,horizontal: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: Color(0xff2c4985),
                            boxShadow: [BoxShadow(color: Color(0x99519251),offset: Offset(0, 3))]
                        ),
                        child: Flex(direction: Axis.vertical,children: <Widget>[
                          Expanded(child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text('分类'),
                          ),
                            flex: 1,),
                          Expanded(child: Container(
                            alignment: Alignment.center,
                            child: Text('共${Map.from(ModalRoute.of(context).settings.arguments)['IndexData']['ProjectClass'].length}分类'),
                          ),
                            flex: 3,)
                        ],),
                      ),
                      onTap: (){
                        Navigator.pushNamed(context, '/ProjectClassList',arguments: {'ProjectClassData':Map.from(ModalRoute.of(context).settings.arguments)['IndexData']['ProjectClass']});
                      },
                    )
                  ],
                ),
              ),
            ),
//            内容
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
            child: Column(
              children: ColumnView(),
            ),
          ),
//            尾部
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
            child: Column(
              children: <Widget>[
                Text('迄今为止收录项目数',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),),
                Container(
                  height: 50,
                  child: Center(
                    child: Text(Map.from(ModalRoute.of(context).settings.arguments)['IndexData']['ProjectCount'],
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Love',
                      color: Color(0xff663399)
                    ),),
                  ),
                )
              ],
            ),
          )
          ],
        ),
      ),
    );
  }
}