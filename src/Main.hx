
import irc.*;

class Main {
  public static function main() {
    var message:Message = "PRIVMSG #channel :Message with :colons!";
    trace(message.debug());

    var message = Message.parse("@color=#FF69B4;display-name=seme_ukulele;emotes=;subscriber=1;turbo=0;user-id=104949876;user-type= :seme_ukulele!seme_ukulele@seme_ukulele.tmi.twitch.tv PRIVMSG #monotonetim :ebe");
    trace(message.debug());
  }
}
