library flutter_html_render;

import 'dart:convert';
import 'ast_model.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}


class HtmlRender{
  HtmlRender(String jsonStr){
    Map nodeMap = jsonDecode(jsonStr);
    // BlockModel block = BlockModel.fromJson(nodeMap);
  }
}