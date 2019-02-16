import 'package:flutter/material.dart';
import '../ast_model.dart';

class ListElement{

  static create(List<Widget> list,List<AttrModel> attrs){
    return ListView(children: list);
  }
}