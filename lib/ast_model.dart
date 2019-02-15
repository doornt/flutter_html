// import 'package:json_annotation/json_annotation.dart';

// part 'BlockModel.g.dart';


class AttrModel{
  String name;
  String val;

  AttrModel();

  factory AttrModel.fromJson(Map<String,dynamic> json){
    AttrModel attr = new AttrModel();
    return attr;
  }
}

class NodeModel{
  String type;
  String name;
  List<AttrModel> attrs;
  BlockModel block;

  NodeModel();

  factory NodeModel.fromJson(Map<String,dynamic> json){
    NodeModel node = new NodeModel();
    json.forEach((String key,dynamic value){
        switch(key){
          case "type":
            node.type = value as String;
            break;
          case "name":
            node.name = value as String;
          break;
          case "attrs":
            node.attrs = (value as List<dynamic>).map((dynamic json)=>AttrModel.fromJson(json as Map<String,dynamic>)).toList();
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