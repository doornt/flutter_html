import 'package:flutter/material.dart';
import '../ast_model.dart';
import 'utils.dart';

class ListElement {
  static build(
      List<Widget> list, List<AttrModel> attrs, Map<String, dynamic> params) {
    var attrMap = Utils.attrArrayToMap(attrs, params);
    return ListView(
      children: list,
      itemExtent: attrMap["itemExtent"] as double,
      padding: Utils.parsePadding(attrMap["padding"]),
    );
  }
}
