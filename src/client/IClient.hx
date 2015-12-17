package client;

interface IClient {

  function join():Void;
  function say(target:String, msg:String, ?params:Array<String>):Void;

  function raw(raw:String):Void;
  function msg(msg:irc.Message):Void;

}
