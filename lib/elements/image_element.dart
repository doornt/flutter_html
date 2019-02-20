import 'package:flutter/material.dart';
import '../ast_model.dart';
import 'utils.dart';

class ImageElement {
  static buildImageAsset(
      List<Widget> list, List<AttrModel> attrs, Map<String, dynamic> params) {
    var attrMap = Utils.attrArrayToMap(attrs, params);

    // TODO: should check src is local asset resource
    assert(attrMap["src"] != null && attrMap["src"].value is String);

    BoxFit fit;
    if (attrMap["fit"] != null) {
      fit = Utils.parseBoxFit(attrMap["fit"].value);
    }

    double width, height;
    if (attrMap["width"] != null) {
      assert(attrMap["width"].isCode);
      width = attrMap["width"].value;
    }

    if (attrMap["height"] != null) {
      assert(attrMap["height"].isCode);
      height = attrMap["height"].value;
    }

    Image image = Image.asset(attrMap["src"].value,
        fit: fit, width: width, height: height);
    return image;
  }
}
