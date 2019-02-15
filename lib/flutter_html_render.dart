library flutter_html_render;

import 'dart:convert';
import 'ast_model.dart';
import 'package:flutter/material.dart';
import 'dart:collection';

class HtmlRender{

  BlockModel _block;

  Widget _root;

  Queue<NodeModel> _queue = new Queue();

  HtmlRender(String jsonStr){
    Map nodeMap = jsonDecode(jsonStr);
    this._block = BlockModel.fromJson(nodeMap);
  }


  _visitTag(NodeModel node){

    Widget _widget;

    switch(node.name){
      case "Column":
      _widget = Column();
    }
  }

  _visit(NodeModel node){
    switch(node.type){
      case "Tag":
        _visitTag(node);
        break;
    }
  }


  Widget _parseWidget(NodeModel node){
      NodeModel pNode;
      _queue.addLast(node);
      while(_queue.length > 0){
        pNode = _queue.removeLast();
        _visit(pNode);
        if(pNode.block != null && pNode.block.nodes.length > 0){
          pNode.block.nodes.forEach((NodeModel n){
            _queue.addLast(n);
          });
        }
      }
      return _root;
  }

  Widget toWidget(){
    if(this._block.nodes.length == 0){
      return Container();
    }
    
    NodeModel node = this._block.nodes[0];

    return this._parseWidget(node);


  }
}