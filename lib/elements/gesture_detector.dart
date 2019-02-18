import 'package:flutter/material.dart';
import '../ast_model.dart';
import 'utils.dart';

class GestureElement{

  static buildDetector(List<Widget> list,List<AttrModel> attrs,Map<String ,dynamic> params) {

    var attrMap = Utils.attrArrayToMap(attrs,params);

    if(list.length == 0){
      return GestureDetector();
    }

    var onTap;

    if(attrMap["onTap"] != null && attrMap["onTap"].value is Function){
      onTap = attrMap["onTap"].value(params["__index"]);
    }

    return GestureDetector(child: list[0],onTap: onTap);    


  }
}