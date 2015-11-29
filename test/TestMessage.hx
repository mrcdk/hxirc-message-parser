import irc.*;
import utest.Assert;

typedef MessageTest = {
  var expected:Message;
  var rawMessage:String;
  @:optional var rawPrefix:String;
  @:optional var rawTags:String;
  @:optional var hostmask:Bool;
  @:optional var server:Bool;
}

class TestMessage {

  var messages:Array<MessageTest>;

  public function new() {}

  public function setup() {
    messages = [
      {
        rawMessage: ":a!b@c QUIT",
        rawPrefix: "a!b@c",
        expected: {
          var prefix = new Prefix("a","b","c");
          var command = Command.QUIT;
          var params = null;
          var trailing = null;
          new Message(prefix, command, params, trailing);
        },
        hostmask: true
      },
      {
        rawMessage: ":a!b PRIVMSG :message",
        rawPrefix: "a!b",
        expected: {
          var prefix = new Prefix("a","b");
          var command = Command.PRIVMSG;
          var params = null;
          var trailing = "message";
          new Message(prefix, command, params, trailing);
        },
      },
      {
        rawMessage: ":a@c NOTICE ::::Hey!",
        rawPrefix: "a@c",
        expected: {
          var prefix = new Prefix("a",null,"c");
          var command = Command.NOTICE;
          var params = null;
          var trailing = ":::Hey!";
          new Message(prefix, command, params, trailing);
        },
      },
      {
        rawMessage: ":nick PRIVMSG $@ :This message contains a\ttab!",
        rawPrefix: "nick",
        expected: {
          var prefix = new Prefix("nick");
          var command = Command.PRIVMSG;
          var params = ["$@"];
          var trailing = "This message contains a\ttab!";
          new Message(prefix, command, params, trailing);
        },
      },

      {
        rawMessage: "TOPIC #foo :",
        rawPrefix: "",
        expected: {
          var prefix = new Prefix();
          var command = Command.TOPIC;
          var params = ["#foo"];
          var trailing = "";
          new Message(prefix, command, params, trailing);
        },
      },

      {
        rawMessage: ":syrk!kalt@millennium.stealth.net QUIT :Gone to have lunch",
        rawPrefix: "syrk!kalt@millennium.stealth.net",
        expected: {
          var prefix = new Prefix("syrk","kalt","millennium.stealth.net");
          var command = Command.QUIT;
          var params = null;
          var trailing = "Gone to have lunch";
          new Message(prefix, command, params, trailing);
        },
        hostmask: true
      },

      {
        rawMessage: ":Trillian SQUIT cm22.eng.umd.edu :Server out of control",
        rawPrefix: "Trillian",
        expected: {
          var prefix = new Prefix("Trillian");
          var command = Command.SQUIT;
          var params = ["cm22.eng.umd.edu"];
          var trailing = "Server out of control";
          new Message(prefix, command, params, trailing);
        },
        server: true
      },


      {
        rawMessage: "@color=#FF69B4;display-name=seme_ukulele;emotes=;subscriber=1;turbo=0;user-id=104949876;user-type= :seme_ukulele!seme_ukulele@seme_ukulele.tmi.twitch.tv PRIVMSG #monotonetim :ebe",
        rawPrefix: "seme_ukulele!seme_ukulele@seme_ukulele.tmi.twitch.tv",
        rawTags: "color=#FF69B4;display-name=seme_ukulele;emotes=;subscriber=1;turbo=0;user-id=104949876;user-type=",
        expected: {
          var prefix = new Prefix("seme_ukulele","seme_ukulele","seme_ukulele.tmi.twitch.tv");
          var command = Command.PRIVMSG;
          var params = ["#monotonetim"];
          var trailing = "ebe";
          new Message(prefix, command, params, trailing);
        },
        hostmask: true
      },

    ];
  }

  public function testMessages() {
    for(test in messages) {

      var expected = test.expected;
      var message = Message.parse(test.rawMessage);

      function testPrefix(prefix:Prefix) {
        Assert.notNull(prefix);
        Assert.same(expected.prefix, prefix);
        Assert.equals(test.rawPrefix, (prefix:String));

        if(test.hostmask) {
          Assert.isTrue(prefix.isHostmask, 'Prefix "${test.rawPrefix}" should be a hostmask.');
        }

        if(test.server) {
          Assert.isTrue(prefix.isServer, 'Prefix "${test.rawPrefix}" should be a server.');
        }
      }

      if(test.rawPrefix != null) {
        var prefix = Prefix.parse(test.rawPrefix);
        testPrefix(prefix);
      }

      if(message != null) {
        testPrefix(message.prefix);
        Assert.equals(expected.command, message.command);
        if(expected.params == null) {
          Assert.isNull(message.params);
        } else {
          Assert.same(expected.params, message.params);
        }
        if(expected.trailing == null) {
          Assert.isNull(message.trailing);
        } else {
          Assert.equals(expected.trailing, message.trailing);
        }


        if(test.rawTags != null) {
          Assert.warn("Skipping Message.toString() because tags aren't implemented.");
          continue;
        }

        Assert.equals(test.rawMessage, (message:String));

      }
    }
  }

  public function teardown() {
    messages = null;
  }

}
