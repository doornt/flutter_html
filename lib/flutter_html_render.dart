library flutter_html_render;

import 'dart:convert';
import 'ast_model.dart';
import 'package:flutter/material.dart';
import 'elements/Flex.dart';

class HtmlRender{

  BlockModel _block;

  Widget _root;

  // Queue<NodeModel> _queue = new Queue();

  HtmlRender(String jsonStr){
    Map nodeMap = jsonDecode(jsonStr);
    this._block = BlockModel.fromJson(nodeMap);
  }


  _visitTag(NodeModel node){

    Widget _widget;

    List<Widget> list = [];
    if(node.block != null && node.block.nodes.length > 0){
      node.block.nodes.forEach((NodeModel n){
        var res = _visit(n);
        if(n != null){
          list.add(res);
        }
      });
    }

    switch(node.name){
      case "Column":
        _widget = FlexElement.buildColumn(list,node.attrs);
        break;
      case "Row":
        _widget = FlexElement.buildRow(list,node.attrs);
        break;

      case "Container":
        if(list.length > 0){
          _widget = Container(child: list[0],);
        }else{
          _widget = Container();
        }
        break;
      
    }

    return _widget;
  }

  Widget _visit(NodeModel node){
    Widget _widget;
    switch(node.type){
      case "Tag":
        _widget = _visitTag(node);
        break;
    }
    return _widget;
  }


  Widget _parseWidget(NodeModel node){
      // NodeModel pNode;
      // _queue.addLast(node);
      // while(_queue.length > 0){
      //   pNode = _queue.removeLast();
      //   _visit(pNode);
      //   if(pNode.block != null && pNode.block.nodes.length > 0){
      //     pNode.block.nodes.forEach((NodeModel n){
      //       _queue.addLast(n);
      //     });
      //   }
      // }
      _root = _visit(node);
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