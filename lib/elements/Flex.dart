import 'package:flutter/material.dart';
import '../ast_model.dart';
import 'utils.dart';

class FlexElement{

  static VerticalDirection _checkVerticalDirection(AttrProperty prop){
    if(prop.isCode){
      return prop.value;
    }
    switch(prop.value){
      case "dow":{
        return VerticalDirection.down;
      }
      case "up":{
        return VerticalDirection.up;
      }
    }
    return VerticalDirection.down;
  }

  static buildColumn(List<Widget> list,List<AttrModel> attrs,Map<String ,dynamic> params){
    var attrMap = Utils.attrArrayToMap(attrs,params);
    var col = new Column(children: list,
      verticalDirection: _checkVerticalDirection(attrMap["verticalDirection"]),
      
    );
   
    return col;
    // col.direction
  }

  static buildRow(List<Widget> list,List<AttrModel> attrs,Map<String ,dynamic> params){
    var col = new Row(children: list);
    return col;
  }

 
}