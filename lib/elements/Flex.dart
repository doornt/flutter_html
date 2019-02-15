import 'package:flutter/material.dart';
import '../ast_model.dart';

class FlexElement{

  static Map<String,String> attrArrayToMap(List<AttrModel> attrs){
    Map<String,String> map = {};
    attrs.forEach((AttrModel attr){
      map[attr.name] = map[attr.val];
    });
    return map;
  }

  static VerticalDirection _checkVerticalDirection(String val){
    switch(val){
      case "dow":{
        return VerticalDirection.down;
      }
      case "up":{
        return VerticalDirection.up;
      }
    }
    return VerticalDirection.down;
  }

  static buildColumn(List<Widget> list,List<AttrModel> attrs){
    var attrMap = attrArrayToMap(attrs);
    var col = new Column(children: list,
      verticalDirection: _checkVerticalDirection(attrMap["verticalDirection"]),
      
    );
   
    return col;
    // col.direction
  }

  static buildRow(List<Widget> list,List<AttrModel> attrs){
    var col = new Row(children: list);
    return col;
  }

}