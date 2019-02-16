import 'package:flutter/material.dart';
import '../ast_model.dart';
import 'dart:convert';
import 'utils.dart';

class TextElement{

 // Text
  static buildText(List<Widget> list,List<AttrModel> attrs,Map<String ,dynamic> params) {

    var attrMap = Utils.attrArrayToMap(attrs,params);

    assert(attrMap["text"] != null);
    
    TextStyle style;
    if (attrMap["style"] != null) {
      style =_parseStyle(attrMap["style"].value as String);
    }
    var text = new Text(attrMap["text"].value, 
                        textAlign: _textAlignMap[attrMap["textAlign"]],
                        overflow: _overflowMap[attrMap["overflow"]],
                        style: style);
    return text;
  }

  static _parseStyle(String style) {
    Map styleMap = json.decode(style);

    // color
    Color color = Utils.parseColor(styleMap["color"]);

    // fontSize
    double fontSize;
    if (styleMap["fontSize"] != null) {
      fontSize = double.parse(styleMap["fontSize"]);
    }
    
    // this.fontWeight,
    FontWeight fontWeight = _parseFontWeight(styleMap["fontWeight"]);

    // this.fontStyle,
    FontStyle fontStyle = _parseFontStyle(styleMap["fontStyle"]);

    return TextStyle(color: color, fontSize: fontSize, fontStyle: fontStyle, fontWeight: fontWeight);
  }

  static _parseFontStyle(String fontStyle) {
    final Map fontStyleMap = {
      "normal": FontStyle.normal,
      "italic": FontStyle.italic
    };

    return fontStyleMap[fontStyle];
  }

  static _parseFontWeight(String fontWeight) {
    final Map fontWeightMap = {
      "w100": FontWeight.w100,
      "w200": FontWeight.w200,
      "w300": FontWeight.w300,
      "w400": FontWeight.w400,
      "w500": FontWeight.w500,
      "w600": FontWeight.w600,
      "w700": FontWeight.w700,
      "w900": FontWeight.w900,
      "normal": FontWeight.normal,
      "bold": FontWeight.bold
    };

    return fontWeightMap[fontWeight];
  }

  static final _overflowMap = {
    "clip":TextOverflow.clip,
    "fade": TextOverflow.fade,
    "ellipsis": TextOverflow.ellipsis
  };

  static final _textAlignMap = {
    "left":TextAlign.left,
    "center": TextAlign.center,
    "right": TextAlign.right,
    "justify": TextAlign.justify,
    "start": TextAlign.start,
    "end": TextAlign.end
  };

}