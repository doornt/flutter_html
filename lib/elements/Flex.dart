import 'package:flutter/material.dart';
import '../ast_model.dart';
import 'dart:convert';
import 'dart:math';

class FlexElement{

  static Map<String,String> attrArrayToMap(List<AttrModel> attrs){
    Map<String,String> map = {};
    attrs.forEach((AttrModel attr){
      map[attr.name] = attr.val;
    });
    return map;
  }

  static VerticalDirection _checkVerticalDirection(String val){
    switch(val){
      case "dow":{
        return VerticalDirection.down;
      }
      case "up":{
        return VerticalDirection.up;
      }
    }
    return VerticalDirection.down;
  }

  static buildColumn(List<Widget> list,List<AttrModel> attrs){
    var attrMap = attrArrayToMap(attrs);
    var col = new Column(children: list,
      verticalDirection: _checkVerticalDirection(attrMap["verticalDirection"]),
      
    );
   
    return col;
    // col.direction
  }

  static buildRow(List<Widget> list,List<AttrModel> attrs){
    var col = new Row(children: list);
    return col;
  }

  // Text
  static buildText(List<Widget> list,List<AttrModel> attrs) {

    var attrMap = attrArrayToMap(attrs);

    assert(attrMap["text"] != null);
    
    TextStyle style;
    if (attrMap["style"] != null) {
      style =_parseStyle(attrMap["style"]);
    }
    var text = new Text(attrMap["text"], 
                        textAlign: _textAlignMap[attrMap["textAlign"]],
                        overflow: _overflowMap[attrMap["overflow"]],
                        style: style);
    return text;
  }

  static _parseStyle(String style) {
    Map styleMap = json.decode(style);

    // color
    Color color = _parseColor(styleMap["color"]);

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

  // color should be #AARRGGBB;
  static _parseColor(String colorString) {
    var colorInt = int.parse(colorString.substring(1, min(9, colorString.length)), radix: 16);
    assert(colorInt is int);
    return Color(colorInt);
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