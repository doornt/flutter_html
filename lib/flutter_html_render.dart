library flutter_html_render;

import 'dart:convert';
import 'ast_model.dart';
import 'package:flutter/material.dart';

class HtmlRender{

  BlockModel _block;

  HtmlRender(String jsonStr){
    Map nodeMap = jsonDecode(jsonStr);
    this._block = BlockModel.fromJson(nodeMap);
  }

  Widget _parseWidget(NodeModel node){
    return Container();
  }

  Widget toWidget(){
    if(this._block.nodes.length == 0){
      return Container();
    }
    
    NodeModel node = this._block.nodes[0];

    return this._parseWidget(node);


  }
}