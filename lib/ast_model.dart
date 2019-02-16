// import 'package:json_annotation/json_annotation.dart';

// part 'BlockModel.g.dart';


class AttrModel{
  String name;
  String val;

  AttrModel();

  factory AttrModel.fromJson(Map<String,dynamic> json){
    AttrModel attr = new AttrModel();
    
    json.forEach((String key,dynamic value){
        switch(key){
          case "val":
            attr.val = value as String;
            break;
          case "name":
            attr.name = value as String;
          break;
        }
      });

    return attr;
  }
}

class NodeModel{
  String type;
  String name;
  String obj;
  String val;
  List<AttrModel> attrs;
  BlockModel block;

  NodeModel();

  factory NodeModel.fromJson(Map<String,dynamic> json){
    NodeModel node = new NodeModel();
    json.forEach((String key,dynamic value){
        switch(key){
          case "type":
          case "name":
          case "obj":
          case "val":
            node.obj = value as String;
          break;
          case "attrs":
            node.attrs = (value as List<dynamic>).map((dynamic json)=>AttrModel.fromJson(json as Map<String,dynamic>)).toList();
            break;
          case "block":
            node.block = BlockModel.fromJson(value);
            break;
        }
      });
      return node;
  }
}

class BlockModel{
    String type;
    List<NodeModel> nodes;

    BlockModel();

    factory BlockModel.fromJson(Map<String,dynamic> json){

      BlockModel block = new BlockModel();

      json.forEach((String key,dynamic value){
        switch(key){
          case "type":
            block.type = value as String;
            break;
          case "nodes":
            block.nodes = (value as List<dynamic>).map((dynamic json)=>NodeModel.fromJson(json as Map<String,dynamic>)).toList();
            break;
        }
      });
      return block;
    }
}