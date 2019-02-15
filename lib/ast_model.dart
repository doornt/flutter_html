import 'package:json_annotation/json_annotation.dart';

// part 'BlockModel.g.dart';


@JsonSerializable()
class AttrModel{
  String name;
  String val;
}

@JsonSerializable()
class NodeModel{
  String type;
  String name;
  List<AttrModel> attrs;
  BlockModel block;
}

@JsonSerializable()
class BlockModel{
    String type;
    List<NodeModel> nodes;
    // factory BlockModel.fromJson(Map<String,dynamic> json) => _$BlockModelFromJson(json);
}