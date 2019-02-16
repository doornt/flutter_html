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
    attrs.forEach((AttrModel attr){
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