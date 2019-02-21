import 'package:flutter/material.dart';
import 'package:flutter_html_render/flutter_html_render.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  HtmlRender render;

  Future<String> loadAsset() async {
    return await rootBundle.loadString('test/outputs/layout.pug.json');
  }

  @override
  void initState() {
    super.initState();
    loadAsset().then((fileStr){
      setState(() {
        render = HtmlRender(fileStr);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: render?.toWidget({}),
      )
    );
  }
}
