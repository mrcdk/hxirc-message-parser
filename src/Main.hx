
import irc.*;

class Main {
  public static function main() {

    var message = Message.parse("@color=#FF69B4;display-name=Arklancer;emotes=9801:0-3/33:5-12,37-44;mod=0;subscriber=1;turbo=0;user-id=40725190;user-type= :arklancer!arklancer@arklancer.tmi.twitch.tv PRIVMSG #twitchplayspokemon :AtWW DansGame Lyrics version or riot DansGame");
    trace(message.debug());
  }
}
