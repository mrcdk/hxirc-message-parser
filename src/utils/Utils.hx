package utils;

class Utils {
  public static inline function len<T:({public var length(default, null):Int;})>(o:T):Int {
    return o == null ? 0 : o.length;
  }
}
