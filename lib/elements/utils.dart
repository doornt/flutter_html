import '../ast_model.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:convert';

class AttrProperty {
  bool isCode = false;

  dynamic value;

  AttrProperty(this.isCode, this.value);
}

double toDouble(dynamic data) {
  if (data is String) {
    return 0;
  }
  if (data is int) {
    return data.toDouble();
  }
  if (data is double) {
    return data;
  }
  return 0;
}

int doubleToInt(double num) {
  if (num is double) {
    return num.toInt();
  }
  return 0;
}

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

const AlignmentMap = {
  "center": Alignment.center,
  "centerLeft": Alignment.centerLeft,
  "topCenter": Alignment.topCenter
};

class Utils {
  static Map<String, AttrProperty> attrArrayToMap(
      List<AttrModel> attrs, Map<String, dynamic> params) {
    Map<String, AttrProperty> map = {};

    params = params ?? {};

    attrs.forEach((AttrModel attr) {
      if (params["__key"] is String) {
        String key = params["__key"];
        if (key == attr.val && params["value"] != null) {
          map[attr.name] = AttrProperty(true, params["value"]);
          return;
        }
        if (attr.val.startsWith(params["__key"] + ".")) {
          String codeVal = attr.val.replaceFirst(params["__key"] + ".", "");
          if (params[codeVal] != null) {
            map[attr.name] = AttrProperty(true, params[codeVal]);
            return;
          }
        }
      }

      if (attr.val.length > 1 &&
          attr.val[0] == "\"" &&
          attr.val[attr.val.length - 1] == "\"") {
        map[attr.name] =
            AttrProperty(false, attr.val.substring(1, attr.val.length - 1));
        return;
      }

      if (isNumeric(attr.val)) {
        map[attr.name] = AttrProperty(true, double.parse(attr.val));
        return;
      }

      if (params[attr.val] != null) {
        map[attr.name] = AttrProperty(true, params[attr.val]);
        return;
      }

      map[attr.name] = AttrProperty(false, attr.val);
    });
    return map;
  }

  // color should be #AARRGGBB;
  static Color parseColor(String colorString) {
    if (colorString != null && colorString.startsWith("#")) {
      var colorInt = int.parse(
          colorString.substring(1, min(9, colorString.length)),
          radix: 16);
      assert(colorInt is int);
      return Color(colorInt);
    }
    return null;
  }

  static parseBoxFit(String boxFitString) {
    final boxFitMap = {
      "fill": BoxFit.fill,
      "contain": BoxFit.contain,
      "cover": BoxFit.cover,
      "fitWidth": BoxFit.fitWidth,
      "fitHeight": BoxFit.fitHeight,
      "none": BoxFit.none,
      "scaleDown": BoxFit.scaleDown
    };

    return boxFitMap[boxFitString];
  }

  static EdgeInsetsGeometry parsePadding(AttrProperty paddingAttr) {
    EdgeInsetsGeometry padding;
    if (paddingAttr != null) {
      var obj = json.decode(paddingAttr.value as String);
      if (obj is List && obj.length == 4) {
        padding = EdgeInsets.only(
            top: toDouble(obj[0]),
            right: toDouble(obj[1]),
            bottom: toDouble(obj[2]),
            left: toDouble(obj[3]));
      }
    }
    return padding ?? EdgeInsets.all(0);
  }

  static Alignment parseAlignment(AttrProperty attr) {
    Alignment align;
    if (attr != null) {
      align = AlignmentMap[attr.value];
    }
    return align;
  }
}
