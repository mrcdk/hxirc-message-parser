package irc;

using StringTools;

@:enum abstract Command(String) {
  // IRC commands extracted from RFC2812 section 3 and RFC2813 section 4.

  var PASS     = "PASS";
  var NICK     = "NICK";
  var USER     = "USER";
  var OPER     = "OPER";
  var MODE     = "MODE";
  var SERVICE  = "SERVICE";
  var QUIT     = "QUIT";
  var SQUIT    = "SQUIT";
  var JOIN     = "JOIN";
  var PART     = "PART";
  var TOPIC    = "TOPIC";
  var NAMES    = "NAMES";
  var LIST     = "LIST";
  var INVITE   = "INVITE";
  var KICK     = "KICK";
  var PRIVMSG  = "PRIVMSG";
  var NOTICE   = "NOTICE";
  var MOTD     = "MOTD";
  var LUSERS   = "LUSERS";
  var VERSION  = "VERSION";
  var STATS    = "STATS";
  var LINKS    = "LINKS";
  var TIME     = "TIME";
  var CONNECT  = "CONNECT";
  var TRACE    = "TRACE";
  var ADMIN    = "ADMIN";
  var INFO     = "INFO";
  var SERVLIST = "SERVLIST";
  var SQUERY   = "SQUERY";
  var WHO      = "WHO";
  var WHOIS    = "WHOIS";
  var WHOWAS   = "WHOWAS";
  var KILL     = "KILL";
  var PING     = "PING";
  var PONG     = "PONG";
  var ERROR    = "ERROR";
  var AWAY     = "AWAY";
  var REHASH   = "REHASH";
  var DIE      = "DIE";
  var RESTART  = "RESTART";
  var SUMMON   = "SUMMON";
  var USERS    = "USERS";
  var WALLOPS  = "WALLOPS";
  var USERHOST = "USERHOST";
  var ISON     = "ISON";
  var SERVER   = "SERVER";
  var NJOIN    = "NJOIN";

  // IRC commands extracted from the IRCv3 spec at http=//www.ircv3.org/.

  var CAP       = "CAP";
  var CAP_LS    = "LS";    // Subcommand (param)
  var CAP_LIST  = "LIST";  // Subcommand (param)
  var CAP_REQ   = "REQ";   // Subcommand (param)
  var CAP_ACK   = "ACK";   // Subcommand (param)
  var CAP_NAK   = "NAK";   // Subcommand (param)
  var CAP_CLEAR = "CLEAR"; // Subcommand (param)
  var CAP_END   = "END";   // Subcommand (param)
  var AUTHENTICATE = "AUTHENTICATE";

  // Numeric IRC replies extracted from RFC2812 section 5.

  var RPL_WELCOME           = "001";
  var RPL_YOURHOST          = "002";
  var RPL_CREATED           = "003";
  var RPL_MYINFO            = "004";
  var RPL_BOUNCE            = "005";
  var RPL_USERHOST          = "302";
  var RPL_ISON              = "303";
  var RPL_AWAY              = "301";
  var RPL_UNAWAY            = "305";
  var RPL_NOWAWAY           = "306";
  var RPL_WHOISUSER         = "311";
  var RPL_WHOISSERVER       = "312";
  var RPL_WHOISOPERATOR     = "313";
  var RPL_WHOISIDLE         = "317";
  var RPL_ENDOFWHOIS        = "318";
  var RPL_WHOISCHANNELS     = "319";
  var RPL_WHOWASUSER        = "314";
  var RPL_ENDOFWHOWAS       = "369";
  var RPL_LISTSTART         = "321";
  var RPL_LIST              = "322";
  var RPL_LISTEND           = "323";
  var RPL_UNIQOPIS          = "325";
  var RPL_CHANNELMODEIS     = "324";
  var RPL_NOTOPIC           = "331";
  var RPL_TOPIC             = "332";
  var RPL_INVITING          = "341";
  var RPL_SUMMONING         = "342";
  var RPL_INVITELIST        = "346";
  var RPL_ENDOFINVITELIST   = "347";
  var RPL_EXCEPTLIST        = "348";
  var RPL_ENDOFEXCEPTLIST   = "349";
  var RPL_VERSION           = "351";
  var RPL_WHOREPLY          = "352";
  var RPL_ENDOFWHO          = "315";
  var RPL_NAMREPLY          = "353";
  var RPL_ENDOFNAMES        = "366";
  var RPL_LINKS             = "364";
  var RPL_ENDOFLINKS        = "365";
  var RPL_BANLIST           = "367";
  var RPL_ENDOFBANLIST      = "368";
  var RPL_INFO              = "371";
  var RPL_ENDOFINFO         = "374";
  var RPL_MOTDSTART         = "375";
  var RPL_MOTD              = "372";
  var RPL_ENDOFMOTD         = "376";
  var RPL_YOUREOPER         = "381";
  var RPL_REHASHING         = "382";
  var RPL_YOURESERVICE      = "383";
  var RPL_TIME              = "391";
  var RPL_USERSSTART        = "392";
  var RPL_USERS             = "393";
  var RPL_ENDOFUSERS        = "394";
  var RPL_NOUSERS           = "395";
  var RPL_TRACELINK         = "200";
  var RPL_TRACECONNECTING   = "201";
  var RPL_TRACEHANDSHAKE    = "202";
  var RPL_TRACEUNKNOWN      = "203";
  var RPL_TRACEOPERATOR     = "204";
  var RPL_TRACEUSER         = "205";
  var RPL_TRACESERVER       = "206";
  var RPL_TRACESERVICE      = "207";
  var RPL_TRACENEWTYPE      = "208";
  var RPL_TRACECLASS        = "209";
  var RPL_TRACERECONNECT    = "210";
  var RPL_TRACELOG          = "261";
  var RPL_TRACEEND          = "262";
  var RPL_STATSLINKINFO     = "211";
  var RPL_STATSCOMMANDS     = "212";
  var RPL_ENDOFSTATS        = "219";
  var RPL_STATSUPTIME       = "242";
  var RPL_STATSOLINE        = "243";
  var RPL_UMODEIS           = "221";
  var RPL_SERVLIST          = "234";
  var RPL_SERVLISTEND       = "235";
  var RPL_LUSERCLIENT       = "251";
  var RPL_LUSEROP           = "252";
  var RPL_LUSERUNKNOWN      = "253";
  var RPL_LUSERCHANNELS     = "254";
  var RPL_LUSERME           = "255";
  var RPL_ADMINME           = "256";
  var RPL_ADMINLOC1         = "257";
  var RPL_ADMINLOC2         = "258";
  var RPL_ADMINEMAIL        = "259";
  var RPL_TRYAGAIN          = "263";
  var ERR_NOSUCHNICK        = "401";
  var ERR_NOSUCHSERVER      = "402";
  var ERR_NOSUCHCHANNEL     = "403";
  var ERR_CANNOTSENDTOCHAN  = "404";
  var ERR_TOOMANYCHANNELS   = "405";
  var ERR_WASNOSUCHNICK     = "406";
  var ERR_TOOMANYTARGETS    = "407";
  var ERR_NOSUCHSERVICE     = "408";
  var ERR_NOORIGIN          = "409";
  var ERR_NORECIPIENT       = "411";
  var ERR_NOTEXTTOSEND      = "412";
  var ERR_NOTOPLEVEL        = "413";
  var ERR_WILDTOPLEVEL      = "414";
  var ERR_BADMASK           = "415";
  var ERR_UNKNOWNCOMMAND    = "421";
  var ERR_NOMOTD            = "422";
  var ERR_NOADMININFO       = "423";
  var ERR_FILEERROR         = "424";
  var ERR_NONICKNAMEGIVEN   = "431";
  var ERR_ERRONEUSNICKNAME  = "432";
  var ERR_NICKNAMEINUSE     = "433";
  var ERR_NICKCOLLISION     = "436";
  var ERR_UNAVAILRESOURCE   = "437";
  var ERR_USERNOTINCHANNEL  = "441";
  var ERR_NOTONCHANNEL      = "442";
  var ERR_USERONCHANNEL     = "443";
  var ERR_NOLOGIN           = "444";
  var ERR_SUMMONDISABLED    = "445";
  var ERR_USERSDISABLED     = "446";
  var ERR_NOTREGISTERED     = "451";
  var ERR_NEEDMOREPARAMS    = "461";
  var ERR_ALREADYREGISTRED  = "462";
  var ERR_NOPERMFORHOST     = "463";
  var ERR_PASSWDMISMATCH    = "464";
  var ERR_YOUREBANNEDCREEP  = "465";
  var ERR_YOUWILLBEBANNED   = "466";
  var ERR_KEYSET            = "467";
  var ERR_CHANNELISFULL     = "471";
  var ERR_UNKNOWNMODE       = "472";
  var ERR_INVITEONLYCHAN    = "473";
  var ERR_BANNEDFROMCHAN    = "474";
  var ERR_BADCHANNELKEY     = "475";
  var ERR_BADCHANMASK       = "476";
  var ERR_NOCHANMODES       = "477";
  var ERR_BANLISTFULL       = "478";
  var ERR_NOPRIVILEGES      = "481";
  var ERR_CHANOPRIVSNEEDED  = "482";
  var ERR_CANTKILLSERVER    = "483";
  var ERR_RESTRICTED        = "484";
  var ERR_UNIQOPPRIVSNEEDED = "485";
  var ERR_NOOPERHOST        = "491";
  var ERR_UMODEUNKNOWNFLAG  = "501";
  var ERR_USERSDONTMATCH    = "502";

  // Numeric IRC replies extracted from the IRCv3 spec.

  var RPL_LOGGEDIN    = "900";
  var RPL_LOGGEDOUT   = "901";
  var RPL_NICKLOCKED  = "902";
  var RPL_SASLSUCCESS = "903";
  var ERR_SASLFAIL    = "904";
  var ERR_SASLTOOLONG = "905";
  var ERR_SASLABORTED = "906";
  var ERR_SASLALREADY = "907";
  var RPL_SASLMECHS   = "908";

  inline function new(s:String) this = s;

  @:from inline static function fromString(s:String) {
    return new Command(s.toUpperCase().trim());
  }

}
