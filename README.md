# flutter_html

A new Flutter package project.

## Getting Started

To use this plugin, add `flutter-html-render` as a dependency in your pubspec.yaml file.

---

1. install nodejs package 

`npm install -g flutter-render`

2. create views folder in project

3. create views folder in assets

4. open terminal and excute cmd `flutter-render --dir views --out assets/out`

5. add output views folder in pubspec.yaml

## Example

```

  HtmlRender render;

  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/views/xxx.json');
  }

  @override
  void initState() {
    super.initState();
    loadAsset().then((fileStr){
      render = HtmlRender(fileStr);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: render?.toWidget({})
    );
  }

```