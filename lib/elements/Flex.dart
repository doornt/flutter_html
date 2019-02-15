import 'package:flutter/material.dart';
import '../ast_model.dart';

class FlexElement{


  static buildColumn(List<Widget> list,List<AttrModel> attrs){
    var col = new Column(children: list);
    return col;
    // col.direction
  }

  static buildRow(List<Widget> list,List<AttrModel> attrs){
    var col = new Row(children: list);
    return col;
  }

}