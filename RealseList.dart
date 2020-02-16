import 'package:flutter/material.dart';

import 'Tools/SetStatusColorTool.dart';

class RealseList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RealseList();
  }
}

class _RealseList extends State<RealseList>{

  RealseListView(){
    List<Widget> list = [];
    for(var i in Map.from(ModalRoute.of(context).settings.arguments)['RealseData']){
      var a = GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, '/RealseView',arguments: {'RealseNumber':i});
        },
        child: Chip(label: Text(i),
        avatar: CircleAvatar(
            backgroundColor: Colors.blue, child: Icon(Icons.bookmark)
        ),),
      );
      list.add(a);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SetStatusColor();
    return Scaffold(
      appBar: AppBar(
        title: Text('选择刊数'),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Wrap(
            spacing: 8.0, // 主轴(水平)方向间距
            runSpacing: 4.0, // 纵轴（垂直）方向间距
            alignment: WrapAlignment.center, //沿主轴方向居中
            children: RealseListView(),
          ),
        ),
      ),
    );
  }
}