import 'package:flutter/material.dart';
import '../ast_model.dart';
import 'utils.dart';

const Map VerMap = {"down": VerticalDirection.down, "up": VerticalDirection.up};

class FlexElement {
  static buildColumn(
      List<Widget> list, List<AttrModel> attrs, Map<String, dynamic> params) {
    var attrMap = Utils.attrArrayToMap(attrs, params);
    var col = new Column(
      children: list,
      verticalDirection:
          VerMap[attrMap["verticalDirection"]?.value] ?? VerticalDirection.down,
    );

    return col;
    // col.direction
  }

  static buildRow(
      List<Widget> list, List<AttrModel> attrs, Map<String, dynamic> params) {
    var attrMap = Utils.attrArrayToMap(attrs, params);
    var col = new Row(
      children: list,
      verticalDirection:
          VerMap[attrMap["verticalDirection"]?.value] ?? VerticalDirection.down,
    );
    return col;
  }

  static buildContainer(
      List<Widget> list, List<AttrModel> attrs, Map<String, dynamic> params) {
    var attrMap = Utils.attrArrayToMap(attrs, params);
    var height = attrMap["height"]?.value;
    var width = attrMap["width"]?.value;
    return new Container(
        height: height,
        width: width,
        child: list.length > 0 ? list[0] : Container());
  }
}
