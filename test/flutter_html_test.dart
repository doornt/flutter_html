import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_html_render/flutter_html_render.dart';

import 'dart:io';

void main() {
  test('HtmlRender',() {
    final file = new File('test/outputs/layout.pug.json');
    HtmlRender html = HtmlRender( file.readAsStringSync());
    html.toWidget();
  });

}
