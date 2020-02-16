import 'package:flutter/material.dart';

import 'Tools/SetStatusColorTool.dart';

class ProjectClassList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProjectClassList();
  }
}

class _ProjectClassList extends State<ProjectClassList>{

  ProjectClassListView(){
    List<Widget> list = [];
    for(var i in Map.from(ModalRoute.of(context).settings.arguments)['ProjectClassData']){
      var a = GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, '/ProjectClassView',arguments: {'ProjectClass':i});
        },
        child: Chip(label: Text(i),
          avatar: CircleAvatar(
              backgroundColor: Colors.blue, child: Icon(Icons.class_)
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
        title: Text('选择项目分类'),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Wrap(
            spacing: 8.0, // 主轴(水平)方向间距
            runSpacing: 4.0, // 纵轴（垂直）方向间距
            alignment: WrapAlignment.center, //沿主轴方向居中
            children: ProjectClassListView(),
          ),
        ),
      ),
    );
  }
}