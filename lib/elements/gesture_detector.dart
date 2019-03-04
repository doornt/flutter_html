import 'package:flutter/material.dart';
import '../ast_model.dart';
import 'utils.dart';

class GestureElement {
  static buildDetector(
      List<Widget> list, List<AttrModel> attrs, Map<String, dynamic> params) {
    var attrMap = Utils.attrArrayToMap(attrs, params);

    if (list.length == 0) {
      return GestureDetector();
    }

    var onTap;
    var index = params["__index"] ?? -1;
    if (attrMap["onTap"] != null && attrMap["onTap"].value is Function) {
      var func = attrMap["onTap"].value;
      if (func is RenderCallback0) {
        onTap = () => func();
      } else if (func is RenderCallback1) {
        onTap = () => func(index);
      } else {
        onTap = () => {};
      }
    }

    return GestureDetector(child: list[0], onTap: onTap);
  }
}
