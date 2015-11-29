package irc;

typedef TagDef = {
  var key:String;
  var value:String;
  @:optional var vendor:String;
}

@:forward()
abstract Tag(TagDef) {

}
