package client;

import sys.net.Socket;
import sys.net.Host;
import thx.ReadonlyArray;
import haxe.io.Bytes;

class Connection {

  public static var sockets(get, never):ReadonlyArray<Socket>;
    inline static function get_sockets() return _sockets;
  static var _sockets(default, null):Array<Socket> = [];

  public var socket(default, null):Socket;
  public var connected(default, null):Bool = false;

  var buffer:haxe.io.Bytes;

  public function new(host:String, ?port:Int = 6667) {

    buffer = Bytes.alloc(4096);

    try {
      socket = new Socket();
      socket.connect(new Host(host), port);
      socket.setBlocking(false);

      _sockets.push(socket);

      connected = true;
      trace("Connection");
    } catch(e:Dynamic) {
      trace('ERROR $e');
      _sockets.remove(socket);
      socket = null;
    }
  }

  public function update(?timeout:Float = 0) {
    if(!connected) return;
    
    try {
      var select = Socket.select(_sockets, null, null, timeout);
      for(read in select.read) {
        readData(read);
      }
    } catch(e:haxe.io.Eof) {
      trace("EOF");
      close();
    }

  }

  public function close() {
    _sockets.remove(socket);
    socket.close();
    socket = null;
  }

  function readData(socket:Socket) {
    var byte = 0;
    var recv = 0;
    var len = buffer.length;

    while(recv < len) {
      try {
        byte = socket.input.readByte();
      } catch(e:haxe.io.Error) {
        if(e == Blocked) {
          // end of stream
          buffer.set(recv, byte);
          break;
        }
      }

      buffer.set(recv, byte);
      recv++;

    }

    if(recv > 0) {
      trace(Std.string(buffer));
    }

  }

}
