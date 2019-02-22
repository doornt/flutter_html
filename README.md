# flutter_html

A Flutter package for rendering html pug template file as Flutter widgets.

## Getting Started

To use this plugin, add `flutter_html_render` as a dependency in your pubspec.yaml file.

---

1. install nodejs package 

`npm install -g flutter-render`

2. create views folder in project root directory

3. create views folder in assets

4. open terminal and excute cmd `flutter-render --dir views --out assets/views`

5. add output views folder in pubspec.yaml

## Example

```
  Column
    Text(text="Hello World")
    ListView(padding=[1,2,3,4])
      each item in list
            Text(text=item.text)

```

```

  HtmlRender render;

  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/views/main.pug.json');
  }

  _hotReload(){
    loadAsset().then((fileStr){
      setState(() {
        render = HtmlRender(fileStr);
      });
    });
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
        child: render?.toWidget({"list":[{"text":"1"},{"text":"2"}]})
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _hotReload,
        child: Icon(Icons.refresh),
      ),
    );
  }

```


## TAGS

`tips:Style Tag will be added soon!`

### Column

```
  Column(verticalDirection="down")
    Tag
    Tag
    ...
```

### Row

```
  Row(verticalDirection="down")
    Tag
    Tag
    ...
```

### Container

```
  Container(width=160 height=100 alignment="topCenter" margin=[top,right,bottom,left] padding=[top,right,bottom,left])
    Tag ## only one child is allowed
```

### ListView

```

  ListView(padding=[top,right,bottom,left])
    each row in list
      ...
```

```
  ListView(padding=[top,right,bottom,left])
    Tag
    Tag
    ...
```

