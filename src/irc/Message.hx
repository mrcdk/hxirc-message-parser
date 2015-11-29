package irc;

using StringTools;
using utils.Utils;

typedef MessageDef = {
  @:optional var tags:Array<Tag>;
  @:optional var prefix:Prefix;
  var command:Command;
  @:optional var params:Array<String>;
  @:optional var trailing:String;
}

@:forward()
abstract Message(MessageDef) {

  public inline function new(?tags:Array<Tag>, ?prefix:Prefix, command:Command,
    ?params:Array<String>, ?trailing:String) {
      this = {tags:tags, prefix:prefix, command:command,
         params:params, trailing:trailing};
  }

  @:from
  public static function parse(raw:String):Message {

    var tags:String = "";
    var prefix:String = "";
    var paramsStr:String = "";
    var command:Command = null;
    var params:Array<String> = null;
    var trailing:String = null;

    raw = raw.trim();

    var cursor:Int = 0;
    inline function adv(char:String = " ", ?start:Int) {
      cursor = raw.indexOf(char, start);
      return cursor = (cursor > -1 ? cursor : raw.length) + char.length;
    }

    var tagsIdx = raw.indexOf("@");
    var prefixIdx = raw.indexOf(":");
    if(tagsIdx == 0 && prefixIdx > tagsIdx) {
      tags = raw.substring(1, adv());
      prefix = raw.substring(prefixIdx+1, adv(prefixIdx));
    } else if (prefixIdx == 0) {
      prefix = raw.substring(1, adv());
    } else if (tagsIdx == 0) {
      tags = raw.substring(1, adv());
    } else {
      // no tags or prefix
    }

    command = raw.substring(cursor, adv(cursor));

    if(cursor < raw.length) {
      // We need to find the first <space>: that marks the end of the params
      // so we have to start from one character before and remove the <space>:
      paramsStr = raw.substring(cursor, adv(" :", cursor - 1) - 1).trim();
      params = paramsStr.len() > 0 ? paramsStr.split(" ") : null;
    }

    if(cursor <= raw.length) {
      trailing = raw.substring(cursor);
    }

    trace("\n" + raw +
          "\n\ttags: " + tags +
          "\n\tprefix: " + prefix +
          "\n\tcommand: " +  command +
          "\n\tparamsStr: " + paramsStr +
          "\n\tparams: " +  params +
          "\n\ttrailing: " +  trailing);

    return new Message(Prefix.parse(prefix), command, params, trailing);
  }

  @:to
  function toString():String {
    var s = "";
    var tags      = this.tags.len() > 0;
    var prefix    = this.prefix != null && !this.prefix.isEmpty();
    var command   = this.command != null;
    var params    = this.params.len() > 0;
    var trailing  = this.trailing != null;
    inline function spc(b) return b ? ' ' : '';
    if(tags)     s += '@${this.tags.join(";")}';
    if(prefix)   s += '${spc(tags)}:${this.prefix}';
    if(command)  s += '${spc(prefix)}${this.command}';
    if(params)   s += '${spc(command)}${this.params.join(" ")}';
    if(trailing) s += '${spc(command || params)}:${this.trailing}';

    return s;
  }

}
