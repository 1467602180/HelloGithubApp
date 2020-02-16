import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

ShowErrorDialog(context,text){
  showDialog(context: context,builder: (_){
    return AlertDialog(
      title: Row(
        children: <Widget>[
          Icon(Icons.error),
          Text('错误提示'),
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
      content: Text(text),
      actions: <Widget>[
        FlatButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('确定'))
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
    );
  });
}

ShowLoadingDialog(context){
  showDialog(context: context,builder: (_){
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: AlertDialog(
        title: Text('请求中，请稍候'),
        content: Container(
          height: 50,
          child: Center(
            child: SpinKitCircle(
              color: Colors.black,
              size: 50.0,
            )
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
      ),
    );
  },
  barrierDismissible: false);
}