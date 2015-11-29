package;

import irc.*;

class Main {
  public static function main() {
    var msg = new Message(new Prefix("thecodec", "thecodec", "tmi.twitch.tv"), Command.PRIVMSG, ["#monotonetim"], "Hello world.");
    trace((msg.prefix:String));

    var p:Prefix = "a!b@c";
    trace(("a!b@c":Prefix));

    var m = Message.parse(":a!b PRIVMSG :message");

    trace(msg);
    trace(m);
    //trace(Codes.map.get(200).name);
  }
}
