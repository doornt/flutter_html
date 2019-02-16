import 'package:flutter/material.dart';
import '../ast_model.dart';
import 'utils.dart';

class DividerElement{

  static buildDivider(List<Widget> list,List<AttrModel> attrs,Map<String ,dynamic> params) {

    var attrMap = Utils.attrArrayToMap(attrs,params);

    double height;
    if (attrMap["height"] != null) {
      if (!(attrMap["height"].value is double)) {
        height = double.parse(attrMap["height"].value);
      } else {
        height = attrMap["height"].value;
      }
    }
    

    assert(height == null || (height is double && height >= 0.0));

    double indent;
    if (attrMap["indent"] != null) {
      if (!(attrMap["indent"].value is double)) {
        indent = double.parse(attrMap["indent"].value);
      } else {
        indent = attrMap["indent"].value;
      }    
    }
    
    indent = indent ?? 0.0;

    Color color;
    if (attrMap["color"] != null) {
      color = Utils.parseColor(attrMap["color"].value);
    }
    
    Divider divider = Divider(height: height, indent: indent, color: color);

    return divider;

  }
}