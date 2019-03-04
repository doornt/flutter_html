import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_html_render/flutter_html_render.dart';

import 'dart:io';

void main() {
  test('HtmlRender',() {
    final file = new File('test/outputs/layout.pug.json');
    HtmlRender html = HtmlRender( file.readAsStringSync());

    Map<String,dynamic> params = {};

    RenderCallback1 onTap = (int param1){

    };

    params["list"] = ["abcd", "efg"];
    params["onTap"] = onTap;

    

    html.toWidget(params);
  });

}
