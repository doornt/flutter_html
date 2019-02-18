import 'package:flutter/material.dart';
import '../ast_model.dart';
import 'utils.dart';
import 'dart:convert';

class ListElement{

  static build(List<Widget> list,List<AttrModel> attrs,Map<String ,dynamic> params){
    var attrMap = Utils.attrArrayToMap(attrs,params);

    EdgeInsetsGeometry padding;

    if(attrMap["padding"] != null){
      var obj = json.decode(attrMap["padding"].value as String);
      if(obj is List && obj.length == 4){
        padding = EdgeInsets.only(
          top:  toDouble(obj[0]) ,
          right: toDouble(obj[1]),
          bottom: toDouble(obj[2]),
          left: toDouble(obj[3])
        );
      }
    }

    return ListView(children: list,
      itemExtent: attrMap["itemExtent"] as double ,
      padding: padding,
    );
  }
}