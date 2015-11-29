package irc;

using StringTools;
using utils.Utils;

typedef PrefixDef = {
  @:optional var nick:String;
  @:optional var user:String;
  @:optional var host:String;
}

@:forward()
abstract Prefix(PrefixDef) {
  // alias to nick
  public var servername(get, set):String;

  public var isHostmask(get, never):Bool;
  public var isServer(get, never):Bool;

  public inline function new(?nick:String, ?user:String, ?host:String)
    this = {nick:nick, user:user, host:host};

  public inline function isEmpty() {
    return !isHostmask && servername.len() <= 0;
  }

  inline function get_servername() return this.nick;
  inline function set_servername(s) return this.nick = s;

  inline function get_isHostmask() return this.user.len() > 0 && this.host.len() > 0;

  inline function get_isServer() return !isHostmask && servername.len() > 0;

  @:from
  public static function parse(raw:String):Prefix {

    var user = raw.indexOf("!");
    var host = raw.indexOf("@");

    var prefix = new Prefix();
    raw = raw.trim();

    if(raw.length <= 0) return prefix;

    if(user > -1 && host > user) {
      prefix.nick = raw.substring(0, user);
      prefix.user = raw.substring(user+1, host);
      prefix.host = raw.substring(host+1);
    } else if (user > -1) {
      prefix.nick = raw.substring(0, user);
      prefix.user = raw.substring(user+1);
    } else if (host > -1) {
      prefix.servername = raw.substring(0, host);
      prefix.host = raw.substring(host+1);
    } else {
      // We have a servername
      prefix.servername = raw;
    }

    return prefix;

  }

  @:to
  inline function toString():String {
    var s = "";
    if(this.nick.len() > 0) s += '${this.nick}';
    if(this.user.len() > 0) s += '!${this.user}';
    if(this.host.len() > 0) s += '@${this.host}';
    return s;
  }



}
