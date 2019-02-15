import 'package:flutter_test/flutter_test.dart';

// import 'package:flutter_html_render/flutter_html_render.dart';

import 'dart:io';

void main() {
  test('adds one to input values', () {
    // final calculator = Calculator();
    // expect(calculator.addOne(2), 3);
    // expect(calculator.addOne(-7), -6);
    // expect(calculator.addOne(0), 1);
    // expect(() => calculator.addOne(null), throwsNoSuchMethodError);
  });

  test('HtmlRender',() async {
    final file = new File('test/outputs/layout.pug.json');
    print(file.readAsStringSync());
    // HtmlRender html = HtmlRender(await file.readAsString());
  });

}
