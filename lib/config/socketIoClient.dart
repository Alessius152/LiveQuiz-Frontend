
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketConfig {
  static final IO.Socket socket = IO.io(
    'http://192.168.0.250:3001',
    IO.OptionBuilder()
        .setTransports(['websocket'])
        .disableAutoConnect()
        .build(),
  );

  static void connect() {
    socket.connect();
  }

  static void disconnect() {
    socket.disconnect();
  }
}
