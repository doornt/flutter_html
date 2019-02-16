import '../ast_model.dart';

class AttrProperty{

  bool isCode = false;

  dynamic value;

  AttrProperty(this.isCode,this.value);

}



bool isNumeric(String s) {
  if(s == null) {
    return false;
  }
  return double.parse(s) != null;
}

class Utils{
  static Map<String,AttrProperty> attrArrayToMap(List<AttrModel> attrs,Map<String ,dynamic> params){
    Map<String,AttrProperty> map = {};

    params = params == null?{}:params;

    attrs.forEach((AttrModel attr){
      if(params["__key"] is String && attr.val.startsWith(params["__key"])){
        String codeVal = attr.val.replaceFirst(params["__key"], "");
        if(params[codeVal] != null){
          map[attr.name] = AttrProperty(true, params[codeVal]);
          return;
        }
      }
      
      if(attr.val.length > 1 && attr.val[0] == "\"" &&  attr.val[attr.val.length - 1] == "\""){
        map[attr.name] = AttrProperty(false, attr.val.substring(1,attr.val.length -1));
      }else if(params[attr.val] != null){
        if(isNumeric(params[attr.val])){
          map[attr.name] = AttrProperty(true, double.parse(attr.val));
        }else{
          map[attr.name] = AttrProperty(true, params[attr.val]);
        }
      }else{
        map[attr.name] = AttrProperty(false, attr.val);
      }
    });
    return map;
  } 
}