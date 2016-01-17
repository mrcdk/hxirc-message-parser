package utils;

class Utils {
  public static inline function len<T:({public var length(default, null):Int;})>(o:T):Int {
    return o == null ? -1 : o.length;
  }

  public static function escapeTags(s:String):String {
    s = (~/\\/g).replace(s, "\\\\");
    s = (~/;/g).replace(s, ':');
    s = (~/ /g).replace(s, "\\s");
    s = (~/\n/g).replace(s, "\\n");
    s = (~/\r/g).replace(s, "\\r");
    return s;
  }

  public static function unescapeTags(s:String):String {
    s = (~/:/g).replace(s, ';');
    s = (~/\\s/g).replace(s, " ");
    s = (~/\\\\/g).replace(s, "\\");
    s = (~/\\n/g).replace(s, "\n");
    s = (~/\\r/g).replace(s, "\r");
    return s;
  }
}
