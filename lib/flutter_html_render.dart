library flutter_html_render;

import 'dart:convert';
import 'ast_model.dart';
import 'package:flutter/material.dart';
import 'elements/Flex.dart';
import 'elements/Text.dart';
import 'elements/ListView.dart';
import 'elements/Divider.dart';
import 'elements/GestureDetector.dart';

class HtmlRender{

  BlockModel _block;

  Widget _root;

  // Map<String ,dynamic> _params;

  // Queue<NodeModel> _queue = new Queue();

  HtmlRender(String jsonStr){
    Map nodeMap = jsonDecode(jsonStr);
    this._block = BlockModel.fromJson(nodeMap);
  }


  _visitTag(NodeModel node,Map<String ,dynamic> envParams){

    Widget _widget;

    List<Widget> list = [];
    if(node.block != null && node.block.nodes.length > 0){
      node.block.nodes.forEach((NodeModel n){
        if(n.type == "Each"){
          var eachList = _visitEach(n,envParams);
          list.addAll(eachList??[]);
          return;
        }
        var res = _visit(n,envParams);
        if(n != null){
          list.add(res);
        }
      });
    }

    var params = envParams ?? {};

    switch(node.name){
      case "Column":
        _widget = FlexElement.buildColumn(list,node.attrs,params);
        break;
      case "Row":
        _widget = FlexElement.buildRow(list,node.attrs,params);
        break;
      case "Text":
        _widget = TextElement.buildText(list, node.attrs,params);
        break;
      case "ListView":
        _widget = ListElement.build(list, node.attrs,params);
      break;
      case "Divider":
        _widget = DividerElement.buildDivider(list, node.attrs,params);
        break;
      case "GestureDetector":
        _widget = GestureElement.buildDetector(list, node.attrs, params);
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


  _visitCode(NodeModel node,Map<String ,dynamic> envParams){
    throw "暂不支持";
  }

  _visitEach(NodeModel node,Map<String ,dynamic> envParams){
    List<Widget> widget= [];

    var values = envParams[node.obj];

    if(values != null && values is List){
      values.forEach((dynamic value){
         if(node.block != null && node.block.nodes.length > 0 && value is Map){
           for(var i=0;i<node.block.nodes.length;i++){
             var n = node.block.nodes[i];
             if(n.type == "Tag"){
                value["__key"] = node.val + ".";
                value["__index"] = i.toString();
                var res = _visitTag(n,value);
                if(n != null){
                  widget.add(res);
                }
             }
           }
        }
      });
    }

    return widget;
  }

  Widget _visit(NodeModel node,Map<String ,dynamic> params){
    Widget _widget;
    switch(node.type){
      case "Tag":
        _widget = _visitTag(node,params);
        break;
      case "Code":
        _widget = _visitCode(node,params);
        break;
      // case "Each":
      //   _widget = _visitEach(node);
      //   break;
    }
    return _widget;
  }


  Widget _parseWidget(NodeModel node,Map<String ,dynamic> params){
      _root = _visit(node,params);
      return _root;
  }

  Widget toWidget(Map<String ,dynamic> params){
    if(this._block.nodes.length == 0){
      return Container();
    }
    
    NodeModel node = this._block.nodes[0];

    // this._params = params;

    return this._parseWidget(node,params);


  }
}