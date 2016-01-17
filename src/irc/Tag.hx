package irc;

using StringTools;
using utils.Utils;

typedef TagDef = {
  var key:String;
  @:optional var value:String;
  @:optional var vendor:String;
}

@:forward()
abstract Tags(Array<Tag>) from Array<Tag> to Array<Tag> {

  @:from
  public static inline function parse(raw:String):Tags {
    raw = raw.trim();
    return raw.length > 0 ? raw.split(";").map(function(s) return Tag.parse(s.unescapeTags())) : null;
  }

  @:to
  inline function toString():String {
    return this == null ? "" : this.map(function(t) return (t:String).escapeTags()).join(";");
  }

  public function debug() {
    if(this == null) return "";
    return this.map(function(t) return t.debug()).join("\n\t\t");
  }
}

@:forward()
abstract Tag(TagDef) {

  public inline function new(key:String, ?value:String, ?vendor:String) {
    this = {
      key: key,
      value: value,
      vendor: vendor,
    };
  }

  @:from
  public static function parse(raw:String):Tag {
    var key:String = null;
    var value:String = null;
    var vendor:String = null;

    var vendorIdx = raw.indexOf("/");
    var valueIdx = raw.indexOf("=");

    if(vendorIdx > valueIdx) vendorIdx = -1;

    if(vendorIdx > 0 && vendorIdx > 0) {
      vendor = raw.substring(0, vendorIdx);
      key = raw.substring(vendorIdx+1, valueIdx);
      value = raw.substring(valueIdx+1);
    } else if (vendorIdx > 0) {
      vendor = raw.substring(0, vendorIdx);
      key = raw.substring(vendorIdx+1);
    } else if (valueIdx > 0) {
      key = raw.substring(0, valueIdx);
      value = raw.substring(valueIdx+1);
    } else {
      key = raw;
    }

    return new Tag(key, value, vendor);
  }

  @:to
  function toString():String {
    var s = this.key;

    if(this.value.len() >= 0) s += '=${this.value}';
    if(this.vendor.len() > 0) s = '${this.vendor}/$s';

    return s;
  }

  public function debug() {
    return 'key: ${this.key} value: ${this.value} vendor: ${this.vendor}';
  }

}
