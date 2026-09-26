
import 'dart:convert';

import 'package:livequiz_frontend/config/localStore.dart';
import 'package:livequiz_frontend/config/socketIoClient.dart';
import 'package:socket_io_client/socket_io_client.dart';

class JoinData {
  String room;
  String username;
  String? recoveryToken;

  JoinData({this.room = "", this.username = ""});
}

class SessionTokens {
  String? answering;
  String? reconnection;
}

class PlayerClient {
  JoinData joinData = JoinData();
  SessionTokens sessionTokens = SessionTokens();

  final Socket rawSocket = SocketConfig.socket;

  final void Function() onJoined;

  PlayerClient({
    required this.onJoined
  }) {
    rawSocket.on('entered-successfully', (data) async {
      sessionTokens.answering = data['sessionTokens']['answering'];
      sessionTokens.reconnection = data['sessionTokens']['reconnection'];

      await LocalStore.setString("sessionTokens", jsonEncode({
        'answering': sessionTokens.answering,
        'reconnection': sessionTokens.reconnection,
      }));

      onJoined();
    });

    rawSocket.connect();
  }

  void joinRoom({
    required String code,
    required String username,
  }) {
    joinData.room = code;
    joinData.username = username;

    rawSocket.emit('join-room', {
      'room': code,
      'username': username,
    });
  }
}