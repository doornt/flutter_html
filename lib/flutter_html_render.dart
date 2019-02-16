library flutter_html_render;

import 'dart:convert';
import 'ast_model.dart';
import 'package:flutter/material.dart';
import 'elements/Flex.dart';
import 'elements/Text.dart';
import 'elements/ListView.dart';

class HtmlRender{

  BlockModel _block;

  Widget _root;

  Map<String ,dynamic> _params;

  // Queue<NodeModel> _queue = new Queue();

  HtmlRender(String jsonStr){
    Map nodeMap = jsonDecode(jsonStr);
    this._block = BlockModel.fromJson(nodeMap);
  }


  _visitTag(NodeModel node,{Map<String ,dynamic> envParams}){

    Widget _widget;

    List<Widget> list = [];
    if(node.block != null && node.block.nodes.length > 0){
      node.block.nodes.forEach((NodeModel n){
        if(n.type == "Each"){
          var eachList = _visitEach(n);
          list.addAll(eachList??[]);
          return;
        }
        var res = _visit(n);
        if(n != null){
          list.add(res);
        }
      });
    }

    var params =envParams!=null?envParams:this._params;

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


  _visitCode(NodeModel node){
    throw "暂不支持";
  }

  _visitEach(NodeModel node){
    List<Widget> widget= [];

    var values = this._params[node.obj];

    if(values != null && values is List){
      values.forEach((dynamic value){
         if(node.block != null && node.block.nodes.length > 0 && value is Map){
          node.block.nodes.forEach((NodeModel n){
            if(n.type == "Tag"){
              value["__key"] = node.val + ".";
              var res = _visitTag(n,envParams: value);
              if(n != null){
                widget.add(res);
              }
            }
            
          });
        }
      });
    }

    return widget;
  }

  Widget _visit(NodeModel node){
    Widget _widget;
    switch(node.type){
      case "Tag":
        _widget = _visitTag(node);
        break;
      case "Code":
        _widget = _visitCode(node);
        break;
      // case "Each":
      //   _widget = _visitEach(node);
      //   break;
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

  Widget toWidget(Map<String ,dynamic> params){
    if(this._block.nodes.length == 0){
      return Container();
    }
    
    NodeModel node = this._block.nodes[0];

    this._params = params;

    return this._parseWidget(node);


  }
}